import 'dart:developer';
import 'dart:io';

import 'package:clone_voice/globals.dart';
import 'package:clone_voice/models/generated_model.dart';
import 'package:clone_voice/models/list_generated_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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

  @observable
  BannerAd? bannerAd;
  @observable
  bool isBannerAdLoaded = false;

  /// Loads a banner ad.
  void loadBannerAd() {
    String adUnitId = 'ca-app-pub-3753684966275105/8239110410';
    if (Platform.isIOS) {
      adUnitId = 'ca-app-pub-3753684966275105/5625389517';
    }

    if (upgraded.value == true) {
      return;
    }

    bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.largeBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          isBannerAdLoaded = true;
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }

  setContext(BuildContext context) => lcontext = context;

  init() async {
    apiService = ApiService();

    loadBannerAd();
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
