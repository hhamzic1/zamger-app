import 'package:json_annotation/json_annotation.dart';
import 'package:zamgerapp/models/index.dart';
part 'firebaseToken.g.dart';

@JsonSerializable()
class FirebaseToken {
  FirebaseToken();

  Person person;
  String deviceToken;

  factory FirebaseToken.fromJson(Map<String, dynamic> json) =>
      _$FirebaseTokenFromJson(json);
  Map<String, dynamic> toJson() => _$FirebaseTokenToJson(this);
}
