part of 'persons.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Persons _$PersonsFromJson(Map<String, dynamic> json) {
  return Persons()
    ..results = (json['results'] as List)
        ?.map((e) =>
            e == null ? null : Person.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PersonsToJson(Persons instance) => <String, dynamic>{
      'results': instance.results,
    };
