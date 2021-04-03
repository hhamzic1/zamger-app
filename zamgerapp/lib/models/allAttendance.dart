import 'package:json_annotation/json_annotation.dart';
import 'attendance.dart';

part 'allAttendance.g.dart';

@JsonSerializable()
class AllAttendance {
      AllAttendance();

  List<Attendance> attendance;

  factory AllAttendance.fromJson(Map<String,dynamic> json) => _$AllAttendanceFromJson(json);
  Map<String, dynamic> toJson() => _$AllAttendanceToJson(this);
}
