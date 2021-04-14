import 'package:json_annotation/json_annotation.dart';
import 'package:zamgerapp/models/attendance.dart';

import 'homeworkInfo.dart';
part 'detail.g.dart';

@JsonSerializable()
class Detail {
  Detail();

  int id;
  @JsonKey(name: 'Homework')
  HomeworkInfo homework;
  dynamic score;
  List<Attendance> attendance;

  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);
  Map<String, dynamic> toJson() => _$DetailToJson(this);
}
