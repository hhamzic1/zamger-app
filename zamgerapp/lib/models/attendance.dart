import 'package:json_annotation/json_annotation.dart';

import 'ZClass.dart';

part 'attendance.g.dart';

@JsonSerializable()
class Attendance {
  Attendance();

  int presence;
  @JsonKey(name: 'ZClass')
  ZClass zClass;

  factory Attendance.fromJson(Map<String, dynamic> json) =>
      _$AttendanceFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceToJson(this);
}
