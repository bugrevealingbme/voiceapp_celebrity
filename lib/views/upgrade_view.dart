import 'dart:io';

import 'package:clone_voice/core/styles/colors.dart';
import 'package:clone_voice/core/styles/custom_color_scheme.dart';
import 'package:clone_voice/core/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../core/base_view.dart';
import '../globals.dart';
import '../view_model/upgrade_view_model/upgrade_view_model.dart';

class UpgradeView extends StatelessWidget {
  const UpgradeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<UpgradeViewModel>(
        viewModel: UpgradeViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onDispose: (model) => model.dispose(),
        onPageBuilder: (context, viewModel, themeData) => Scaffold(
            backgroundColor: themeData.colorScheme.secondaryBgColor,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close)),
            ),
            body: Stack(
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    themeData.colorScheme.primary,
                    BlendMode.color,
                  ),
                  child: Container(
                    height: AppSizes.height30 * 1.1821,
                    alignment: Alignment.topCenter,
                    decoration: const BoxDecoration(
                      color: Color(0xfffb7671),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        image: AssetImage('assets/pro_banner.png'),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: AppSizes.height30 * 1.1,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 25),
                        decoration: BoxDecoration(
                          color: themeData.colorScheme.background,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "VoiceAPP",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Container(
                                    decoration: BoxDecoration(
                                      color: themeData.colorScheme.primary,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 2),
                                    child: const Text(
                                      "Pro",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Observer(builder: (context) {
                              bool trialAvaible = viewModel
                                          .offerings
                                          ?.current
                                          ?.monthly
                                          ?.storeProduct
                                          .defaultOption
                                          ?.freePhase !=
                                      null &&
                                  viewModel.selectedP == 'monthly';

                              return viewModel.offerings == null
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  viewModel.selectedP =
                                                      'weekly';
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                        width: 1,
                                                        color: viewModel
                                                                    .selectedP ==
                                                                'weekly'
                                                            ? themeData
                                                                .colorScheme
                                                                .primary
                                                            : Colors
                                                                .grey.shade300,
                                                      )),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        "Weekly",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        (viewModel
                                                                .offerings
                                                                ?.current
                                                                ?.weekly
                                                                ?.storeProduct
                                                                .priceString)
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            fontSize: 19,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      const Text(
                                                        "Cancel anytime",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  viewModel.selectedP =
                                                      'monthly';
                                                },
                                                child: Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                            width: 1,
                                                            color: viewModel
                                                                        .selectedP ==
                                                                    'monthly'
                                                                ? themeData
                                                                    .colorScheme
                                                                    .primary
                                                                : themeData
                                                                    .colorScheme
                                                                    .dividerAllColor,
                                                          )),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 5,
                                                          vertical: 10),
                                                      width: double.infinity,
                                                      child: Column(
                                                        children: [
                                                          const Text(
                                                            "Monthly",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Text(
                                                            (viewModel
                                                                    .offerings
                                                                    ?.current
                                                                    ?.monthly
                                                                    ?.storeProduct
                                                                    .priceString)
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    trialAvaible
                                                                        ? 16
                                                                        : 19,
                                                                color: trialAvaible
                                                                    ? themeData
                                                                        .colorScheme
                                                                        .secondaryTextColor
                                                                    : null,
                                                                decoration: trialAvaible
                                                                    ? TextDecoration
                                                                        .lineThrough
                                                                    : null,
                                                                fontWeight: trialAvaible
                                                                    ? FontWeight
                                                                        .w500
                                                                    : FontWeight
                                                                        .w600),
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          trialAvaible
                                                              ? const Text(
                                                                  "3 Days Free Trial",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                )
                                                              : Text(
                                                                  "~${((viewModel.offerings?.current?.monthly?.storeProduct.price ?? 0) / 4).toStringAsFixed(2)} Weekly",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                        ],
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: -11,
                                                      left: 0,
                                                      right: 0,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: themeData
                                                                .colorScheme
                                                                .primary,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 10,
                                                            vertical: 2,
                                                          ),
                                                          child: Text(
                                                            trialAvaible
                                                                ? "Free!"
                                                                : "Save ~15%",
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.health_and_safety_rounded,
                                              size: 14,
                                              color: themeData.colorScheme
                                                  .secondaryTextColor,
                                            ),
                                            const SizedBox(width: 3),
                                            Text(
                                              "Payment is secure",
                                              style: TextStyle(
                                                  color: themeData.colorScheme
                                                      .secondaryTextColor,
                                                  fontSize: 13),
                                            ),
                                            Container(
                                              width: 1.721,
                                              height: 1.721,
                                              color: themeData.colorScheme
                                                  .secondaryTextColor,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                            ),
                                            Text(
                                              "No hidden costs",
                                              style: TextStyle(
                                                  color: themeData.colorScheme
                                                      .secondaryTextColor,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Stack(
                                          children: [
                                            Shimmer.fromColors(
                                              baseColor: themeData
                                                  .colorScheme.buttonColor,
                                              highlightColor: themeData
                                                  .colorScheme.buttonColor
                                                  .withOpacity(0.721),
                                              period: const Duration(
                                                  milliseconds: 1000),
                                              child: Container(
                                                width: double.infinity,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: themeData
                                                      .colorScheme.buttonColor,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: TextButton(
                                                onPressed: () async {
                                                  upgradeFunctionCat(viewModel);
                                                },
                                                child: Text(
                                                  trialAvaible
                                                      ? "Start Free Trial Now!"
                                                      : "Continue",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: AppColors.invert(
                                                          themeData.colorScheme
                                                              .primaryTextColor)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                            }),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "I do later",
                                style: TextStyle(
                                  color:
                                      themeData.colorScheme.secondaryTextColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 125),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Flexible(
                                  child: InkWell(
                                    onTap: () => launchUrlString(
                                        'https://metareverse.net/apps/voice_cloning/privacy.html'),
                                    child: Text(
                                      "Privacy policy",
                                      style: TextStyle(
                                          color: themeData.colorScheme.primary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: InkWell(
                                    onTap: () => launchUrlString(
                                        'https://vpnverse.net/terms.html'),
                                    child: Text(
                                      "Terms of service",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: themeData.colorScheme.primary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: InkWell(
                                      onTap: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();

                                        try {
                                          CustomerInfo customerInfo =
                                              await Purchases
                                                  .restorePurchases();

                                          if (customerInfo
                                              .activeSubscriptions.isNotEmpty) {
                                            upgraded.value = true;
                                            prefs = await SharedPreferences
                                                .getInstance();
                                            prefs.setBool("upgraded", true);

                                            Fluttertoast.showToast(
                                                msg: "Purchase restored");
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "An upgrade was not found");

                                            upgraded.value = false;
                                            prefs = await SharedPreferences
                                                .getInstance();
                                            prefs.setBool("upgraded", false);
                                          }
                                        } on PlatformException {
                                          Fluttertoast.showToast(
                                              msg: "An upgrade was not found");

                                          upgraded.value = false;
                                          prefs = await SharedPreferences
                                              .getInstance();
                                          prefs.setBool("upgraded", false);
                                        }
                                      },
                                      child: Text(
                                        "Restore",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color:
                                                themeData.colorScheme.primary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      )),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              Platform.isIOS
                                  ? "Payment will be charged to your Apple ID account at the confirmation of purchase. Subscription automatically renews unless it is canceled at least 24 hours before the end of the current period. Your account will be charged for renewal within 24 hours prior to the end of the current period. You can manage and cancel your subscriptions by going to your account settings on the App Store after purchase."
                                  : "Subscription may be canceled at any time from the Play Store Settings. All prices include applicable local sales taxes. Payment will be charged to Play Store Account at confirmation of purchase. Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period and identify the cost of the renewal. Subscription may the managed by the user and auto-renewal may be turned off by going to the user's Account Settings after purchase. If a user cancels a subscription purchased from an app on Google Play, Google policy is that the user will not receive a refund for the current billing period, but will continue to receive their subscription content for the remainder of the current billing period, regardless of the cancellation date. The user's cancellation goes into effect after the current billing period has passed.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: themeData.colorScheme.secondaryTextColor
                                    .withOpacity(0.721),
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }

  Future<void> upgradeFunctionCat(UpgradeViewModel viewModel) async {
    try {
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null) {
        try {
          Package? selectedPackage = offerings.current?.monthly;
          if (viewModel.selectedP == 'weekly') {
            selectedPackage = offerings.current?.weekly;
          } else {
            selectedPackage = offerings.current?.monthly;
          }
          CustomerInfo customerInfo = await Purchases.purchasePackage(
              selectedPackage ?? offerings.current!.availablePackages.first);

          if (customerInfo.activeSubscriptions.isNotEmpty) {
            Fluttertoast.showToast(msg: "Successfully upgraded!");
            SharedPreferences prefs = await SharedPreferences.getInstance();

            prefs.setBool("upgraded", true);
            upgraded.value = true;
          }
        } on PlatformException catch (e) {
          var errorCode = PurchasesErrorHelper.getErrorCode(e);
          if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
            Fluttertoast.showToast(msg: "Payment failed!");
          }
        }
      }
    } on PlatformException {
      Fluttertoast.showToast(msg: "Payment failed!");
    }
  }

  vipTopFeatures(String text, IconData icon, ThemeData themeData) {
    return Flexible(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            width: 28,
            height: 28,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: AppColors.invert(themeData.colorScheme.background),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(
              icon,
              size: 19,
              color: AppColors.invert(themeData.colorScheme.primaryTextColor),
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
