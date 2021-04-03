import 'package:json_annotation/json_annotation.dart';
import 'announcement.dart';

part 'announcements.g.dart';

@JsonSerializable()
class Announcements {
      Announcements();

  List<Announcement> results;

  factory Announcements.fromJson(Map<String,dynamic> json) => _$AnnouncementsFromJson(json);
  Map<String, dynamic> toJson() => _$AnnouncementsToJson(this);
}
