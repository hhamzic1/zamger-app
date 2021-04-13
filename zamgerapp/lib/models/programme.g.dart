// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************
part of 'programme.dart';

Programme _$ProgrammeFromJson(Map<String, dynamic> json) {
  return Programme()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..abbrev = json['abbrev'] as String;
}

Map<String, dynamic> _$ProgrammeToJson(Programme instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'abberv': instance.abbrev,
    };
