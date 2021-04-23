import 'package:json_annotation/json_annotation.dart';
import 'package:zamgerapp/models/academicYear.dart';

import 'courseActivity.dart';
import 'exam.dart';

part 'examLatest.g.dart';

@JsonSerializable()
class ExamLatest {
  ExamLatest();

  @JsonKey(name: 'Exam')
  Exam exam;
  dynamic result;

  factory ExamLatest.fromJson(Map<String, dynamic> json) =>
      _$ExamLatestFromJson(json);
  Map<String, dynamic> toJson() => _$ExamLatestToJson(this);
}
