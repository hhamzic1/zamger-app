import 'package:json_annotation/json_annotation.dart';


part 'homeworkInfo.g.dart';

@JsonSerializable()
class HomeworkInfo {
      HomeworkInfo();

  int id;
  String name;
  int nrAssignments;
  int maxScore;
  String deadline;
  bool active;
  bool automatedTesting;
  bool attachment;
  String allowedExtensions;
  String publishedDateTime;
  bool readonly;

  factory HomeworkInfo.fromJson(Map<String,dynamic> json) => _$HomeworkInfoFromJson(json);
  Map<String, dynamic> toJson() => _$HomeworkInfoToJson(this);
}
