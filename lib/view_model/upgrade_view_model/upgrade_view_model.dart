import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:purchases_flutter/purchases_flutter.dart' hide Store;

part 'upgrade_view_model.g.dart';

class UpgradeViewModel = UpgradeViewModelBase with _$UpgradeViewModel;

abstract class UpgradeViewModelBase with Store {
  late BuildContext lcontext;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @observable
  Offerings? offerings;

  @observable
  String selectedP = "monthly";

  setContext(BuildContext context) => lcontext = context;

  init() async {
    offerings = await Purchases.getOfferings();
  }

  dispose() {}
}
