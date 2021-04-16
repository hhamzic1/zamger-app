import 'package:json_annotation/json_annotation.dart';
import 'package:zamgerapp/models/programme.dart';

import 'courseActivity.dart';
import 'courseUnit.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  Event();

  int id;
  @JsonKey(name: 'CourseUnit')
  CourseUnit courseUnit;
  String dateTime;
  dynamic maxStudents;
  String deadline;
  @JsonKey(name: 'CourseActivity')
  CourseActivity courseActivity;
  dynamic registered;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);
}
