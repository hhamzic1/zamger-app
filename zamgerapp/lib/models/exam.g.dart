part of 'exam.dart';

Exam _$ExamFromJson(Map<String, dynamic> json) {
  return Exam()
    ..id = json['id']
    ..courseUnit = json['CourseUnit'] == null
        ? null
        : CourseUnit.fromJson(json['CourseUnit'] as Map<String, dynamic>)
    ..date = json['date']
    ..publishedDateTime = json['publishedDateTime']
    ..courseActivity = json['CourseActivity'] == null
        ? null
        : CourseActivity.fromJson(
            json['CourseActivity'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ExamToJson(Exam instance) => <String, dynamic>{
      'CourseUnit': instance.courseUnit,
      'CourseActivity': instance.courseActivity,
      'date': instance.date,
      'publishedDateTime': instance.publishedDateTime,
      'id': instance.id
    };
