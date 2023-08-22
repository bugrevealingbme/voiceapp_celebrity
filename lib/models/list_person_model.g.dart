// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_person_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListPersonModel _$ListPersonModelFromJson(Map<String, dynamic> json) =>
    ListPersonModel(
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => PersonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListPersonModelToJson(ListPersonModel instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
