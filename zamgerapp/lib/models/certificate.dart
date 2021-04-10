import 'package:json_annotation/json_annotation.dart';
import 'person.dart';
part 'certificate.g.dart';

@JsonSerializable()
class Certificate {
  Certificate();

  @JsonKey(name: 'Certificate')
  Certificate courseOffering;
  dynamic id;
  Person student;
  int certificateType;
  int certificatePurpose;
  dynamic datetime;
  dynamic status;
  dynamic free;

  factory Certificate.fromJson(Map<String, dynamic> json) =>
      _$CertificateFromJson(json);
  Map<String, dynamic> toJson() => _$CertificateToJson(this);
}
