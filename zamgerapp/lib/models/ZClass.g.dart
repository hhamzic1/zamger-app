part of 'ZClass.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZClass _$ZClassFromJson(Map<String, dynamic> json) {
  return ZClass()..dateTime = json['dateTime'];
}

Map<String, dynamic> _$ZClassToJson(ZClass instance) =>
    <String, dynamic>{'dateTime': instance.dateTime};
