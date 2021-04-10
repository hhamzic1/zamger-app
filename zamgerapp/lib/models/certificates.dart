import 'package:json_annotation/json_annotation.dart';
import 'certificate.dart';
import 'message.dart';

part 'certificates.g.dart';

@JsonSerializable()
class Certificates {
  Certificates();

  List<Certificate> results;

  factory Certificates.fromJson(Map<String, dynamic> json) =>
      _$CertificatesFromJson(json);
  Map<String, dynamic> toJson() => _$CertificatesToJson(this);
}
