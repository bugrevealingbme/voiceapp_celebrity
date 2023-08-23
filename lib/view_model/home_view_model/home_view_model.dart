import 'dart:developer';
import 'dart:io';

import 'package:clone_voice/models/list_person_model.dart';
import 'package:clone_voice/models/person_model.dart';
import 'package:clone_voice/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freerasp/freerasp.dart';
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
  List<PersonModel>? celebrities = [];

  @observable
  String selectedId = '';

  @observable
  int tabIndex = 0;

  @observable
  bool? appModded;

  setContext(BuildContext context) => lcontext = context;

  init() async {
    initSecurityState();

    apiService = ApiService();
    initPlatformState();
    prefs = await SharedPreferences.getInstance();

    celebrities = await getList();
  }

  dispose() {
    textController.dispose();
  }

  Future<List<PersonModel>?> getList() async {
    const String url = 'https://apiva.metareverse.net/m1/list-voices';

    Response? response = await apiService.sendPostRequest(
      endPoint: url,
      postData: {},
      headers: await apiService.apiHeader(),
    );

    if (response?.statusCode == HttpStatus.ok) {
      final Map<String, dynamic> data = response?.data;
      final ListPersonModel result = ListPersonModel.fromJson(data);
      selectedId = result.result?[0].id.toString() ?? '';

      return result.result;
    } else {
      log('Error: ${response?.statusCode}');
      log('Error: ${response?.data}');

      return [];
    }
  }

  Future<EventData?> postTTS() async {
    const String url = 'https://apiva.metareverse.net/m1/post-tts';

    Response? response = await apiService.sendPostRequest(
      endPoint: url,
      postData: {
        'selectedId': selectedId,
        'text': textController.text,
      },
      headers: await apiService.apiHeader(),
    );

    if (response?.statusCode == HttpStatus.ok) {
      EventData? eventData = EventData.fromJson(response!.data);

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

  initSecurityState() async {
    /// ThreatTypes to hold current state (Android)
    final ThreatType tamper = ThreatType("Tamper");
    final ThreatType hook = ThreatType("Hook");

    String base64Hash = hashConverter.fromSha256toBase64(
        "05:44:93:AD:36:99:25:A1:CD:C0:42:45:E0:51:12:AE:47:AF:E8:CC:14:95:A9:D6:9A:64:70:85:C1:FA:2D:E3");

    final TalsecConfig config = TalsecConfig(
      androidConfig: AndroidConfig(
        packageName: 'net.metareverse.voiceapp',
        signingCertHashes: [base64Hash],
      ),
      watcherMail: 'abuseapp@metareverse.net',
    );

    final callback = ThreatCallback(
      onAppIntegrity: () => _updateState(tamper),
      onHooks: () => _updateState(hook),
    );
    // Attaching listener
    Talsec.instance.attachListener(callback);

    await Talsec.instance.start(config);

    return;
  }

  void _updateState(final ThreatType type) {
    appModded = true;
    showToast(type.state.toString());

    Navigator.of(lcontext).popUntil((route) => route.isFirst);
    // ignore: parameter_assignments
    type.threatFound();
  }
}
