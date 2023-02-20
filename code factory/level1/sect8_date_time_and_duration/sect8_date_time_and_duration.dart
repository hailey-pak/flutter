// DateTime 및 Duration

void main() {
  DateTime now = DateTime.now();

  print(now);
  print(now.year);
  print(now.month);
  print(now.day);
  print(now.hour);
  print(now.minute);
  print(now.second);
  print(now.millisecond);

  Duration duration = Duration(seconds: 60);
  print(duration);
  print(duration.inDays);
  print(duration.inHours);
  print(duration.inMinutes);
  print(duration.inSeconds);
  print(duration.inMilliseconds);

  DateTime specificDay = DateTime(
    2017,
    10,
    30,
  );

  print(specificDay);

  final differ = now.difference(specificDay);

  print(differ);
  print(differ.inDays);
  print(differ.inHours);
  print(differ.inMinutes);

  print(now.isAfter(specificDay));
  print(now.isBefore(specificDay));

  print(now);
  print(now.add(Duration(hours: 10)));
  print(now.subtract(Duration(seconds: 30)));
}
