import 'package:json_annotation/json_annotation.dart';

part 'programme.g.dart';

@JsonSerializable()
class Programme {
  Programme();

  int id;
  String name;
  String abbrev;

  factory Programme.fromJson(Map<String, dynamic> json) =>
      _$ProgrammeFromJson(json);
  Map<String, dynamic> toJson() => _$ProgrammeToJson(this);
}
