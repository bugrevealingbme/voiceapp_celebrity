import 'package:clone_voice/models/langs_model.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'list_langs_model.g.dart';

@JsonSerializable()
class ListLangsModel {
  List<LangsModel>? result;

  ListLangsModel({
    this.result,
  });

  factory ListLangsModel.fromJson(Map<String, dynamic> json) {
    return _$ListLangsModelFromJson(json);
  }

  fromJson(Map<String, dynamic> json) {
    return _$ListLangsModelFromJson(json);
  }

  Map<String, dynamic>? toJson() {
    return _$ListLangsModelToJson(this);
  }
}
