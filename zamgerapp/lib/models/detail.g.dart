// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Detail _$DetailFromJson(Map<String, dynamic> json) {
  return Detail()
    ..id = json['id'] as int
    ..score = json['score'] as dynamic
    ..homework = json['Homework'] == null
        ? null
        : HomeworkInfo.fromJson(json['Homework'] as Map<String, dynamic>)
    ..attendance = json['attendance'] == null
        ? null
        : (json['attendance'] as List)
            ?.map((e) => e == null
                ? null
                : Attendance.fromJson(e as Map<String, dynamic>))
            ?.toList();
}

Map<String, dynamic> _$DetailToJson(Detail instance) => <String, dynamic>{
      'id': instance.id,
      'Homework': instance.homework,
      'attendance': instance.attendance,
      'score': instance.score
    };
