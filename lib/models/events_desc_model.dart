// ignore_for_file: non_constant_identifier_names

// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

class EventDesc {
  late String About_Event;
  late DateTime Timings;
  late String Venue;
  late int Members_In_Team;
  late int Registration_Fee;
  late Url Registration_Link;
  late String Guests;
  late String Winners;

  EventDesc(
      {required this.About_Event,
      required this.Timings,
      required this.Venue,
      required this.Members_In_Team,
      required this.Registration_Fee});
}
