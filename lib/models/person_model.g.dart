// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonModel _$PersonModelFromJson(Map<String, dynamic> json) => PersonModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      img: json['img'] as String?,
      category: json['category'] as String?,
      gender: json['gender'] as String?,
      manifest: json['manifest'] as String?,
      langCode: json['lang_code'] as String?,
    );

Map<String, dynamic> _$PersonModelToJson(PersonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'img': instance.img,
      'category': instance.category,
      'gender': instance.gender,
      'manifest': instance.manifest,
      'lang_code': instance.langCode,
    };
