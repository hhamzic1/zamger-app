// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Certificates _$CertificatesFromJson(Map<String, dynamic> json) {
  return Certificates()
    ..results = (json['results'] as List)
        ?.map((e) =>
            e == null ? null : Certificate.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CertificatesToJson(Certificates instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
