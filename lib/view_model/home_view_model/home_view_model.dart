import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:purchases_flutter/purchases_flutter.dart' hide Store;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/api_service.dart';
import '../../globals.dart';
import '../../models/event_data.dart';

part 'home_view_model.g.dart';

class HomeViewModel = HomeViewModelBase with _$HomeViewModel;

abstract class HomeViewModelBase with Store {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  TextEditingController textController = TextEditingController();

  late BuildContext lcontext;
  late ApiService apiService;
  late SharedPreferences prefs;

  @observable
  List celebrities = [];

  @observable
  String selectedId = '';

  @observable
  int tabIndex = 0;

  setContext(BuildContext context) => lcontext = context;

  init() async {
    apiService = ApiService();
    initPlatformState();
    prefs = await SharedPreferences.getInstance();

    celebrities = await getList();
  }

  dispose() {
    textController.dispose();
  }

  Future<List> getList() async {
    const String url = 'https://metareverse.net/apps/voice_cloning/list.json';

    Response? response = await apiService.sendGetRequest(
      endPoint: url,
      headers: await apiService.apiHeader(),
    );

    if (response?.statusCode == HttpStatus.ok) {
      selectedId = response?.data[0]['id'];

      return response?.data;
    } else {
      log('Error: ${response?.statusCode}');
      log('Error: ${response?.data}');

      return [];
    }
  }

  Future<EventData?> postTTS() async {
    const String url = 'https://play.ht/api/v2/tts';

    final Map<String, dynamic> requestBody = {
      'quality': 'medium',
      'output_format': 'mp3',
      'speed': 1,
      'sample_rate': 24000,
      'voice': selectedId,
      'text': textController.text,
    };

    Response? response = await apiService.sendPostRequest(
      endPoint: url,
      postData: requestBody,
      headers: await apiService.apiHeader(),
    );

    EventData? eventData;
    if (response?.statusCode == HttpStatus.ok) {
      final List<String> lines = await response?.data.split('\n');

      for (final line in lines) {
        if (line.startsWith('data:')) {
          String newline = line.replaceAll('data:', '');

          try {
            EventData? temp =
                EventData.fromJson(jsonDecode(newline.toString()));

            if (temp.progress == 1) {
              eventData = temp;
            }
          } catch (e) {
            log(response?.data);
          }
        }
      }

      return eventData;
    } else {
      log('Error: ${response?.statusCode}');
      log('Error: ${response?.data}');

      return null;
    }
  }

  Future<void> initPlatformState() async {
    try {
      await Purchases.setLogLevel(LogLevel.debug);

      PurchasesConfiguration configuration;
      configuration =
          PurchasesConfiguration('goog_FslAAyswspbksQeQBUCQhLvCyuL');
      await Purchases.configure(configuration);

      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      if (customerInfo.activeSubscriptions.isNotEmpty) {
        upgraded.value = true;
        prefs.setBool("upgraded", true);
      } else {
        upgraded.value = false;
        prefs.setBool("upgraded", false);
      }
    } on PlatformException {
      upgraded.value = false;
      prefs.setBool("upgraded", false);
    }
  }
}
