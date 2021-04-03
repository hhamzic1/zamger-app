// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcements.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Announcements _$AnnouncementsFromJson(Map<String, dynamic> json) {
  return Announcements()
    ..results = (json['results'] as List)
        ?.map((e) =>
            e == null ? null : Announcement.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AnnouncementsToJson(Announcements instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
