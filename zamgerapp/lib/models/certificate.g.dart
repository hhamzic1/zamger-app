// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************
part of 'certificate.dart';

Certificate _$CertificateFromJson(Map<String, dynamic> json) {
  return Certificate()
    ..courseOffering = json['CourseOffering'] == null
        ? null
        : Certificate.fromJson(json['Certificate'] as Map<String, dynamic>)
    ..student = json['student'] == null
        ? null
        : Person.fromJson(json['student'] as Map<String, dynamic>)
    ..id = json['id']
    ..certificateType = json['CertificateType']
    ..certificatePurpose = json['CertificatePurpose']
    ..requestedDate = json['requestedDate']
    ..processedDate = json['processedDate']
    ..status = json['status']
    ..free = json['free'];
}

Map<String, dynamic> _$CertificateToJson(Certificate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'student': instance.student,
      'CertificateType': instance.certificateType,
      'CertificatePurpose': instance.certificatePurpose,
      'requestedDate': instance.requestedDate,
      'processedDate': instance.processedDate,
      'status': instance.status,
      'free': instance.free
    };
