import 'package:clone_voice/models/generated_model.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'list_generated_model.g.dart';

@JsonSerializable()
class ListGeneratedModel {
  List<GeneratedModel>? result;

  ListGeneratedModel({
    this.result,
  });

  factory ListGeneratedModel.fromJson(Map<String, dynamic> json) {
    return _$ListGeneratedModelFromJson(json);
  }

  fromJson(Map<String, dynamic> json) {
    return _$ListGeneratedModelFromJson(json);
  }

  Map<String, dynamic>? toJson() {
    return _$ListGeneratedModelToJson(this);
  }
}
