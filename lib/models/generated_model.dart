import 'package:clone_voice/models/person_model.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'generated_model.g.dart';

@JsonSerializable()
class GeneratedModel {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'text')
  String? text;

  @JsonKey(name: 'url')
  String? url;

  @JsonKey(name: 'voice')
  PersonModel? voice;

  GeneratedModel({
    this.id,
    this.text,
    this.url,
    this.voice,
  });

  factory GeneratedModel.fromJson(Map<String, dynamic> json) {
    return _$GeneratedModelFromJson(json);
  }

  fromJson(Map<String, dynamic> json) {
    return _$GeneratedModelFromJson(json);
  }

  Map<String, dynamic>? toJson() {
    return _$GeneratedModelToJson(this);
  }
}
