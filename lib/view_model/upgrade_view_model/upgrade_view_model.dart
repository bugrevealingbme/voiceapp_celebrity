import 'dart:io';

import 'package:clone_voice/globals.dart';
import 'package:clone_voice/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mobx/mobx.dart';
import 'package:purchases_flutter/purchases_flutter.dart' hide Store;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

    generateRewardAd();
  }

  @observable
  bool isBannerAdLoaded = false;
  @observable
  RewardedAd? rewardedAd;

  generateRewardAd({bool? show}) async {
    AppLocalizations t = AppLocalizations.of(lcontext)!;

    if (isBannerAdLoaded) {
      await rewardedAd?.show(
        onUserEarnedReward: (ad, reward) {
          rights.value = rights.value - 1;

          Future.delayed(
            Duration.zero,
            () {
              Navigator.pop(lcontext, true);
            },
          );
        },
      );
    } else {
      await RewardedAd.load(
          adUnitId: Platform.isIOS
              ? 'ca-app-pub-3753684966275105/7457894679'
              : 'ca-app-pub-3753684966275105/3167581286',
          request: const AdRequest(),
          rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (RewardedAd ad) {
              rewardedAd = ad;
              isBannerAdLoaded = true;

              if (show == true) {
                ad.show(
                  onUserEarnedReward: (ad, reward) {
                    rights.value = rights.value - 1;

                    Future.delayed(
                      Duration.zero,
                      () {
                        Navigator.pop(lcontext, true);
                      },
                    );
                  },
                );
              }
            },
            onAdFailedToLoad: (LoadAdError error) {
              if (error.message == 'The rewarded ad have been showed.') {}
              showToast(t.currently_unavailable);
            },
          ));
    }
  }

  dispose() {}
}
