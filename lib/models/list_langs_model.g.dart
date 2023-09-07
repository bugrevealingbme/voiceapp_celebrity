// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_langs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListLangsModel _$ListLangsModelFromJson(Map<String, dynamic> json) =>
    ListLangsModel(
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => LangsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListLangsModelToJson(ListLangsModel instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
