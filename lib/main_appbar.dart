import 'package:clone_voice/core/styles/custom_color_scheme.dart';
import 'package:clone_voice/globals.dart';
import 'package:clone_voice/views/upgrade_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'core/styles/values.dart';

AppBar mainAppbar(ThemeData themeData, BuildContext context, {String? title}) {
  return AppBar(
    elevation: 0,
    titleSpacing: AppValues.screenPadding,
    backgroundColor: themeData.colorScheme.background,
    actionsIconTheme:
        IconThemeData(color: themeData.colorScheme.primaryTextColor),
    iconTheme: IconThemeData(color: themeData.colorScheme.primaryTextColor),
    title: Text(
      title ?? 'VoiceApp',
    ),
    centerTitle: false,
    titleTextStyle: TextStyle(
        color: themeData.colorScheme.primaryTextColor,
        fontWeight: FontWeight.w900,
        fontSize: 24),
    toolbarTextStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 15,
      color: themeData.colorScheme.secondaryTextColor,
    ),
    actions: [
      Row(
        children: [
          ValueListenableBuilder(
              valueListenable: upgraded,
              builder: (context, bool upgraded, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppValues.screenPadding),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: upgraded ? 0 : AppValues.screenPadding,
                        vertical: 5),
                    decoration: BoxDecoration(
                      border: upgraded
                          ? null
                          : Border.all(
                              color: themeData.colorScheme.secondaryBgColorDark,
                            ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: InkWell(
                      onTap: upgraded
                          ? () {
                              Fluttertoast.showToast(
                                  msg: "Thanks for the upgrade!");
                            }
                          : () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const UpgradeView(),
                                  ));
                            },
                      child: Row(
                        children: [
                          if (!upgraded) ...[
                            Icon(
                              Icons.lock_sharp,
                              size: 16,
                              color: themeData.colorScheme.secondaryTextColor,
                            ),
                            const SizedBox(width: 5),
                          ],
                          Text(
                            "Pro",
                            style: TextStyle(
                                color: upgraded
                                    ? themeData.colorScheme.secondaryTextColor
                                    : null),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    ],
  );
}
