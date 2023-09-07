// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'langs_model.g.dart';

@JsonSerializable()
class LangsModel {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'code')
  String? code;

  @JsonKey(name: 'flag')
  String? flag;

  LangsModel({
    this.id,
    this.name,
    this.code,
    this.flag,
  });

  factory LangsModel.fromJson(Map<String, dynamic> json) {
    return _$LangsModelFromJson(json);
  }

  fromJson(Map<String, dynamic> json) {
    return _$LangsModelFromJson(json);
  }

  Map<String, dynamic>? toJson() {
    return _$LangsModelToJson(this);
  }
}
