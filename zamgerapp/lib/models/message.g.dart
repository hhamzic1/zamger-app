// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message()
    ..id = json['id'] as int
    ..type = json['type'] as int
    ..scope = json['scope'] as int
    ..receiver = json['receiver'] as int
    ..sender = json['sender'] == null
        ? null
        : Person.fromJson(json['sender'] as Map<String, dynamic>)
    ..time = json['time'] as String
    ..ref = json['ref'] as int
    ..subject = json['subject'] as String
    ..text = json['text'] as String
    ..unread = json['unread'] as bool
    ..receiverPerson = json['receiverPerson'] == null
        ? null
        : Person.fromJson(json['receiverPerson'] as Map<String, dynamic>);
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'scope': instance.scope,
      'receiver': instance.receiver,
      'sender': instance.sender,
      'time': instance.time,
      'ref': instance.ref,
      'subject': instance.subject,
      'text': instance.text,
      'unread': instance.unread,
      'receiverPerson': instance.receiverPerson,
    };
