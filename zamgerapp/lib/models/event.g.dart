// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************
part of 'event.dart';

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event()
    ..id = json['id']
    ..courseUnit = json['CourseUnit'] == null
        ? null
        : CourseUnit.fromJson(json['CourseUnit'] as Map<String, dynamic>)
    ..dateTime = json['dateTime']
    ..maxStudents = json['maxStudents']
    ..deadline = json['deadline']
    ..courseActivity = json['CourseActivity'] == null
        ? null
        : CourseActivity.fromJson(
            json['CourseActivity'] as Map<String, dynamic>)
    ..registered = json['registered'];
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'CourseUnit': instance.courseUnit,
      'CourseActivity': instance.courseActivity,
      'maxStudents': instance.maxStudents,
      'deadline': instance.deadline,
      'dateTime': instance.dateTime,
      'registered': instance.registered,
      'id': instance.id
    };
