// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************
part of 'enrollment.dart';

Enrollment _$EnrollmentFromJson(Map<String, dynamic> json) {
  return Enrollment()
    ..programme = json['Programme'] == null
        ? null
        : Programme.fromJson(json['Programme'] as Map<String, dynamic>)
    ..enrollmentType = json['EnrollmentType'] == null
        ? null
        : EnrollmentType.fromJson(
            json['EnrollmentType'] as Map<String, dynamic>);
}

Map<String, dynamic> _$EnrollmentToJson(Enrollment instance) =>
    <String, dynamic>{
      'Programme': instance.programme,
      'EnrollmentType': instance.enrollmentType,
    };
