// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'person_model.g.dart';

@JsonSerializable()
class PersonModel {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'fake_name')
  String? fakeName;

  @JsonKey(name: 'img')
  String? img;

  @JsonKey(name: 'category')
  String? category;

  @JsonKey(name: 'gender')
  String? gender;

  @JsonKey(name: 'manifest')
  String? manifest;

  @JsonKey(name: 'lang_code')
  String? langCode;

  PersonModel({
    this.id,
    this.name,
    this.fakeName,
    this.img,
    this.category,
    this.gender,
    this.manifest,
    this.langCode,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return _$PersonModelFromJson(json);
  }

  fromJson(Map<String, dynamic> json) {
    return _$PersonModelFromJson(json);
  }

  Map<String, dynamic>? toJson() {
    return _$PersonModelToJson(this);
  }
}
