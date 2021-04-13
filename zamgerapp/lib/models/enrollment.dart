import 'package:json_annotation/json_annotation.dart';
import 'package:zamgerapp/models/programme.dart';

import 'enrollmentType.dart';
part 'enrollment.g.dart';

@JsonSerializable()
class Enrollment {
  Enrollment();

  @JsonKey(name: 'Programme')
  Programme programme;
  @JsonKey(name: 'EnrollmentType')
  EnrollmentType enrollmentType;

  factory Enrollment.fromJson(Map<String, dynamic> json) =>
      _$EnrollmentFromJson(json);
  Map<String, dynamic> toJson() => _$EnrollmentToJson(this);
}
