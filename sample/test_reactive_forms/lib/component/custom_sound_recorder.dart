import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

const theSource = AudioSource.microphone;

class CustomSoundRecorder extends StatefulWidget {
  final String? soundPath;

  const CustomSoundRecorder({
    this.soundPath,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomSoundRecorder> createState() => _CustomSoundRecorderState();
}

class _CustomSoundRecorderState extends State<CustomSoundRecorder> {
  StreamSubscription? _recorderSubscription;
  StreamSubscription? _playerSubscription;
  StreamSubscription? _recordingDataSubscription;

  final FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  final FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();

  String _recorderTxt = '00:00:00';
  String _playerTxt = '00:00:00';
  double? _dbLevel;

  double sliderCurrentPosition = 0.0;
  double maxDuration = 1.0;
  Codec _codec = Codec.aacMP4;
  String _mPath = 'tau_file.mp4';

  bool? _encoderSupported = true; // Optimist
  bool _decoderSupported = true; // Optimist

  StreamController<Food>? recordingDataController;
  IOSink? sink;

  bool _mPlayBackReady = false;
  bool _recorded = false;
  bool _isPlaying = false;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await openTheRecorder();
    await _initializeItems();

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
      AVAudioSessionCategoryOptions.allowBluetooth |
      AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
      AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
  }

  Future<void> _initializeItems() async {
    await _mPlayer.closePlayer();
    await _mPlayer.openPlayer();
    await _mPlayer.setSubscriptionDuration(Duration(milliseconds: 10));
    await _mRecorder.setSubscriptionDuration(Duration(milliseconds: 10));
    await initializeDateFormatting(); // 타이머 텍스 지정을 위해
    await setCodec(_codec);
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      Map<Permission, PermissionStatus> permissions = await [
        Permission.storage,
        Permission.microphone,
      ].request();

      if (permissions[Permission.microphone] != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
      if (permissions[Permission.storage] != PermissionStatus.granted) {
        throw RecordingPermissionException('Storage permission not granted');
      }
    }
    await _mRecorder.openRecorder();

    if (!await _mRecorder.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
      _mPath = 'tau_file.webm';
    }
  }

  Future<void> setCodec(Codec codec) async {
    _encoderSupported = await _mRecorder.isEncoderSupported(codec);
    _decoderSupported = await _mPlayer.isDecoderSupported(codec);

    setState(() {
      _codec = codec;
    });
  }

  void cancelRecorderSubscriptions() {
    if (_recorderSubscription != null) {
      _recorderSubscription!.cancel();
      _recorderSubscription = null;
    }
  }

  void cancelPlayerSubscriptions() {
    if (_playerSubscription != null) {
      _playerSubscription!.cancel();
      _playerSubscription = null;
    }
  }

  void cancelRecordingDataSubscription() {
    if (_recordingDataSubscription != null) {
      _recordingDataSubscription!.cancel();
      _recordingDataSubscription = null;
    }
    recordingDataController = null;
    if (sink != null) {
      sink!.close();
      sink = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _isRecording?
          // 정지 버튼
          renderIconButton(icon: Icons.pause, iconColor: Colors.blue, onTab: stopRecord)
          // 녹음 버튼
          : renderIconButton(
              icon: Icons.mic, iconColor: Colors.red, onTab: record),
          const SizedBox(width: 10),
          _isPlaying?
          // 일시 정지 버튼
          renderIconButton(icon: Icons.pause, iconColor: Colors.black, onTab: stopPlay)
          // 재생 버튼
          : renderIconButton(
              icon: Icons.play_arrow,
              iconColor: Colors.black,
              onTab: play),
          const SizedBox(width: 10),
          // 재생바
          renderPlayer(),
          const SizedBox(width: 10),
          // 재생 시간
          Text(
            _recorderTxt,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 10),
          // 삭제 버튼
          renderIconButton(
              icon: Icons.delete_forever,
              iconColor: Colors.grey,
              onTab: delete),

        ],
      ),
    );
  }

  Widget renderIconButton({
    required IconData icon,
    required iconColor,
    required onTab,
  }) {
    return GestureDetector(
      onTap: onTab,
      child: Icon(
        icon,
        size: 32,
        color: iconColor,
      ),
    );
  }

  Widget renderPlayer() {
    return Container();
  }

  // 녹음 시작
  void record() async {
    var path = '';
    if (!kIsWeb) {
      var tempDir = await getTemporaryDirectory();
      path = '${tempDir.path}/flutter_sound${ext[_codec.index]}';
    } else {
      path = '_flutter_sound${ext[_codec.index]}';
    }

    _mRecorder
        .startRecorder(
      toFile: path,
      codec: _codec,
      audioSource: theSource,
    );

    _recorderSubscription = _mRecorder.onProgress!.listen((e) {
      var date = DateTime.fromMillisecondsSinceEpoch(
          e.duration.inMilliseconds,
          isUtc: true);
      var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);

      setState(() {
        _recorderTxt = txt.substring(0, 8);
        _dbLevel = e.decibels;
      });
    });

  }

  // 녹음 중지
  void stopRecord() async {
    try {
      await _mRecorder.stopRecorder();
      _mRecorder.logger.d('stopRecorder');
      cancelRecorderSubscriptions();
      cancelRecordingDataSubscription();
    } on Exception catch (err) {
      _mRecorder.logger.d('stopRecorder error: $err');
    }
    setState(() {
      _isRecording = false;
    });
  }

  // 녹음 삭제
  void delete() {}

  // 녹음 재생
  void play() async {
    assert( !_isRecording &&
        _mRecorder.isStopped &&
        _mPlayer.isStopped);
    _mPlayer
        .startPlayer(
        fromURI: _mPath,
        //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
        whenFinished: () {
          setState(() {});
        })
        .then((value) {
      _addListeners();
      setState(() {});
    });
  }

  void stopPlay() async {
    try {
      if (_mPlayer.isPlaying) {
        await _mPlayer.pausePlayer();
      } else {
        await _mPlayer.resumePlayer();
      }
    } on Exception catch (err) {
      _mPlayer.logger.e('error: $err');
    }
    setState(() {});
  }

  void pauseResumeRecorder() async {
    try {
      if (_mRecorder.isPaused) {
        await _mRecorder.resumeRecorder();
      } else {
        await _mRecorder.pauseRecorder();
        assert(_mRecorder.isPaused);
      }
    } on Exception catch (err) {
      _mRecorder.logger.e('error: $err');
    }
    setState(() {});
  }

  void _addListeners() {
    cancelPlayerSubscriptions();
    _playerSubscription = _mPlayer.onProgress!.listen((e) {
      maxDuration = e.duration.inMilliseconds.toDouble();
      if (maxDuration <= 0) maxDuration = 0.0;

      sliderCurrentPosition =
          min(e.position.inMilliseconds.toDouble(), maxDuration);
      if (sliderCurrentPosition < 0.0) {
        sliderCurrentPosition = 0.0;
      }

      var date = DateTime.fromMillisecondsSinceEpoch(e.position.inMilliseconds,
          isUtc: true);
      var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
      setState(() {
        _playerTxt = txt.substring(0, 8);
      });
    });
  }

}
