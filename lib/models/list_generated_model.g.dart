// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_generated_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListGeneratedModel _$ListGeneratedModelFromJson(Map<String, dynamic> json) =>
    ListGeneratedModel(
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => GeneratedModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListGeneratedModelToJson(ListGeneratedModel instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
