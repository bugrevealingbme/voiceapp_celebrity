// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generated_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneratedModel _$GeneratedModelFromJson(Map<String, dynamic> json) =>
    GeneratedModel(
      id: json['id'] as int?,
      text: json['text'] as String?,
      url: json['url'] as String?,
      voice: json['voice'] == null
          ? null
          : PersonModel.fromJson(json['voice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeneratedModelToJson(GeneratedModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'url': instance.url,
      'voice': instance.voice,
    };
