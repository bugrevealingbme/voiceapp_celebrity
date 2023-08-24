// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:clone_voice/views/generated_before_view.dart';
import 'package:clone_voice/views/settings.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../views/home_view.dart';

part 'main_view_model.g.dart';

class MainViewModel = MainViewModelBase with _$MainViewModel;

abstract class MainViewModelBase with Store {
  late BuildContext lcontext;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @observable
  List<Widget> viewList = [];

  @observable
  int currentIndex = 0;

  @observable
  bool isPageTop = true;

  @observable
  ValueNotifier<int> currentIndexNotify = ValueNotifier<int>(0);

  @observable
  ValueNotifier<bool> isPageTopNotify = ValueNotifier<bool>(true);

  setContext(BuildContext context) => lcontext = context;

  init() {
    viewList = const [
      HomeView(),
      GeneratedBeforeView(),
      SettingsPage(),
    ];
  }

  dispose() {}

  @action
  updateCurrentIndex(int index) {
    if (index == currentIndex) {
      currentIndexNotify.value = index;

      // ignore: invalid_use_of_protected_member
      currentIndexNotify.notifyListeners();
    }

    return currentIndex = index;
  }
}
