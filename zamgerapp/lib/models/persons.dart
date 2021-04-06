import 'package:json_annotation/json_annotation.dart';
import 'person.dart';
part 'persons.g.dart';

@JsonSerializable()
class Persons {
  Persons();

  List<Person> results;

  factory Persons.fromJson(Map<String, dynamic> json) =>
      _$PersonsFromJson(json);
  Map<String, dynamic> toJson() => _$PersonsToJson(this);
}
