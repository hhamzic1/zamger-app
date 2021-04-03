import 'package:json_annotation/json_annotation.dart';
import 'person.dart';
import 'person.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  Message();

  int id;
  int type;
  int scope;
  int receiver;
  Person sender;
  String time;
  int ref;
  String subject;
  String text;
  bool unread;
  Person receiverPerson;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
