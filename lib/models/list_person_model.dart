import 'package:clone_voice/models/person_model.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'list_person_model.g.dart';

@JsonSerializable()
class ListPersonModel {
  List<PersonModel>? result;

  ListPersonModel({
    this.result,
  });

  factory ListPersonModel.fromJson(Map<String, dynamic> json) {
    return _$ListPersonModelFromJson(json);
  }

  fromJson(Map<String, dynamic> json) {
    return _$ListPersonModelFromJson(json);
  }

  Map<String, dynamic>? toJson() {
    return _$ListPersonModelToJson(this);
  }
}
