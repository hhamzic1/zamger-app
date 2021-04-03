import 'package:json_annotation/json_annotation.dart';
import 'allAttendance.dart';

part 'attendanceOnCourse.g.dart';

@JsonSerializable()
class AttendanceOnCourse {
      AttendanceOnCourse();

  List<AllAttendance> results;

  factory AttendanceOnCourse.fromJson(Map<String,dynamic> json) => _$AttendanceOnCourseFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceOnCourseToJson(this);
}
