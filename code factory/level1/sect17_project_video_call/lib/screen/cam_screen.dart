import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_call/const/agora.dart';

class CamScreen extends StatefulWidget {
  const CamScreen({Key? key}) : super(key: key);

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  RtcEngine? engine;

  // 내 ID
  int? uid = 0;

  // 상대 ID
  int? otherUid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LIVE',
        ),
      ),
      body: FutureBuilder<bool>(
          future: init(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            }

            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      renderMainView(),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          color: Colors.grey,
                          height: 160,
                          width: 120,
                          child: renderSubView(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      //엔진 초기화
                      if (engine != null) {
                        await engine!.leaveChannel();
                        engine = null;
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      '채널 나가기',
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  renderMainView() {
    if (uid == null) {
      return Center(
        child: Text('채널에 참여해주세요.'),
      );
    } else {
      // 채널에 참여하고 있을 때
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: engine!,
          canvas: VideoCanvas(
            uid: 0,
          ),
        ),
      );
    }
  }

  renderSubView() {
    if (otherUid == null) {
      return Center(
        child: Text('채널에 유저가 없습니다.'),
      );
    } else {
      //채널에 상대 유저가 있을 때
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: engine!,
          canvas: VideoCanvas(
            uid: otherUid,
          ),
          connection: RtcConnection(
            channelId: CHANNEL_NAME,
          ),
        ),
      );
    }
  }

  // 권한 요청
  Future<bool> init() async {
    final resp = await [Permission.camera, Permission.microphone].request();

    final cameraPermission = resp[Permission.camera];
    final microphonePermission = resp[Permission.microphone];

    if (cameraPermission != PermissionStatus.granted ||
        microphonePermission != PermissionStatus.granted) {
      throw '카메라 또는 마이크 권한이 없습니다.';
    }

    //엔진 생성
    if (engine == null) {
      engine = createAgoraRtcEngine();

      await engine!.initialize(
        RtcEngineContext(
          appId: APP_ID,
        ),
      );

      // 엔진 시작
      await engine!.enableVideo();
      await engine!.startPreview();

      ChannelMediaOptions options = ChannelMediaOptions();

      await engine!.joinChannel(
        token: TEMP_TOKEN,
        channelId: CHANNEL_NAME,
        uid: 0,
        options: options,
      );
    }

    engine!.registerEventHandler(
      RtcEngineEventHandler(
        // 내가 채널에 입장 했을 때
        // connection -> 연결 정보
        // elapsed -> 연결된 시간 (연결된지 얼마나 됐는지)
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          print('채널에 입장했습니다. uid: ${connection.localUid}');
          setState(() {
            uid = connection.localUid;
          });
        },

        // 내가 채널에서 나갔을 때
        onLeaveChannel: (connection, RtcStats stats) {
          print('채널 퇴장');
          setState(() {
            uid = null;
          });
        },

        // 상대방 유저가 들어 왔을 때
        onUserJoined: (connection, int remoteUid, elapsed) {
          print('상대가 채널에 입장했습니다. otherUid: $remoteUid');
          setState(() {
            otherUid = remoteUid;
          });
        },

        // 상대가 나갔을 때
        onUserOffline: (connection, remoteUid, UserOfflineReasonType reason) {
          print('상대가 채널에서 나갔습니다. otherUid: $remoteUid');
          setState(() {
            otherUid = null;
          });
        },
      ),
    );

    return true;
  }
}
