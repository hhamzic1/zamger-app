import 'package:json_annotation/json_annotation.dart';

part 'enrollmentType.g.dart';

@JsonSerializable()
class EnrollmentType {
  EnrollmentType();

  int id;
  String name;

  factory EnrollmentType.fromJson(Map<String, dynamic> json) =>
      _$EnrollmentTypeFromJson(json);
  Map<String, dynamic> toJson() => _$EnrollmentTypeToJson(this);
}
