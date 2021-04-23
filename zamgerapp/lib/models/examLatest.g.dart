part of 'examLatest.dart';

ExamLatest _$ExamLatestFromJson(Map<String, dynamic> json) {
  return ExamLatest()
    ..exam = json['Exam'] == null
        ? null
        : Exam.fromJson(json['Exam'] as Map<String, dynamic>)
    ..result = json['result'];
}

Map<String, dynamic> _$ExamLatestToJson(ExamLatest instance) =>
    <String, dynamic>{'Exam': instance.exam, 'result': instance.result};
