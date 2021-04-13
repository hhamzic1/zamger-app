// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************
part of 'enrollmentType.dart';

EnrollmentType _$EnrollmentTypeFromJson(Map<String, dynamic> json) {
  return EnrollmentType()
    ..id = json['id'] as int
    ..name = json['name'] as String;
}

Map<String, dynamic> _$EnrollmentTypeToJson(EnrollmentType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
