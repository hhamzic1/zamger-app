import 'package:json_annotation/json_annotation.dart';
import 'package:zamgerapp/models/academicYear.dart';

import 'courseActivity.dart';
import 'courseUnit.dart';

part 'exam.g.dart';

@JsonSerializable()
class Exam {
  Exam();

  int id;
  @JsonKey(name: 'CourseUnit')
  CourseUnit courseUnit;
  @JsonKey(name: 'AcademicYear')
  AcademicYear academicYear;
  String date;
  String publishedDateTime;
  @JsonKey(name: 'CourseActivity')
  CourseActivity courseActivity;

  factory Exam.fromJson(Map<String, dynamic> json) => _$ExamFromJson(json);
  Map<String, dynamic> toJson() => _$ExamToJson(this);
}
