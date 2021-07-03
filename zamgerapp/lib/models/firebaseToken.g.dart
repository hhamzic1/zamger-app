part of 'firebaseToken.dart';

FirebaseToken _$FirebaseTokenFromJson(Map<String, dynamic> json) {
  return FirebaseToken()
    ..person = json['Person'] == null
        ? null
        : Person.fromJson(json['Person'] as Map<String, dynamic>)
    ..deviceToken = json["deviceToken"];
}

Map<String, dynamic> _$FirebaseTokenToJson(FirebaseToken instance) =>
    <String, dynamic>{
      'Person': instance.person,
      'deviceToken': instance.deviceToken
    };
