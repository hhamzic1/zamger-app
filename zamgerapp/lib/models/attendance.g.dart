// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attendance _$AttendanceFromJson(Map<String, dynamic> json) {
  return Attendance()
    ..presence = json['presence'] as int
    ..zClass = json['ZClass'] == null ? null : ZClass.fromJson(json['ZClass']);
}

Map<String, dynamic> _$AttendanceToJson(Attendance instance) =>
    <String, dynamic>{
      'presence': instance.presence,
      'ZClass': instance.zClass,
    };
