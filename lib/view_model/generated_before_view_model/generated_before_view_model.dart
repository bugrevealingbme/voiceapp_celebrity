import 'dart:developer';
import 'dart:io';

import 'package:clone_voice/models/generated_model.dart';
import 'package:clone_voice/models/list_generated_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/services/api_service.dart';

part 'generated_before_view_model.g.dart';

class GeneratedBeforeViewModel = GeneratedBeforeViewModelBase
    with _$GeneratedBeforeViewModel;

abstract class GeneratedBeforeViewModelBase with Store {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  late BuildContext lcontext;
  late ApiService apiService;

  @observable
  List<GeneratedModel>? generatedBefore = [];

  @observable
  int tabIndex = 0;

  setContext(BuildContext context) => lcontext = context;

  init() async {
    apiService = ApiService();

    generatedBefore = await getList();
  }

  dispose() {}

  Future<List<GeneratedModel>?> getList() async {
    const String url = 'https://apiva.metareverse.net/m1/list-generated';

    Response? response = await apiService.sendPostRequest(
      endPoint: url,
      postData: {},
      headers: await apiService.apiHeader(),
    );

    if (response?.statusCode == HttpStatus.ok) {
      final Map<String, dynamic> data = response?.data;
      final ListGeneratedModel result = ListGeneratedModel.fromJson(data);

      return result.result;
    } else {
      log('Error: ${response?.statusCode}');
      log('Error: ${response?.data}');

      return [];
    }
  }
}
