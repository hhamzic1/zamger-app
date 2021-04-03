import 'package:json_annotation/json_annotation.dart';
import 'person.dart';

part 'announcement.g.dart';

@JsonSerializable()
class Announcement {
      Announcement();

  int id;
  dynamic type;
  int scope;
  int receiver;
  Person sender;
  String time;
  int ref;
  String subject;
  String text;
  bool unread;

  factory Announcement.fromJson(Map<String,dynamic> json) => _$AnnouncementFromJson(json);
  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);
}
