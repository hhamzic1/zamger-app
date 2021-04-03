// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendanceOnCourse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceOnCourse _$AttendanceOnCourseFromJson(Map<String, dynamic> json) {
  return AttendanceOnCourse()
    ..results = (json['results'] as List)
        ?.map((e) => e == null
            ? null
            : AllAttendance.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AttendanceOnCourseToJson(AttendanceOnCourse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
