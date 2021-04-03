// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allAttendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllAttendance _$AllAttendanceFromJson(Map<String, dynamic> json) {
  return AllAttendance()
    ..attendance = (json['attendance'] as List)
        ?.map((e) =>
            e == null ? null : Attendance.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AllAttendanceToJson(AllAttendance instance) =>
    <String, dynamic>{
      'attendance': instance.attendance,
    };
