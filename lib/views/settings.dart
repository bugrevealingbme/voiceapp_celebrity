import 'dart:io';

import 'package:clone_voice/core/styles/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../core/styles/values.dart';
import '../custom_text.dart';
import '../main_appbar.dart';
import '../utils.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    AppLocalizations t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: mainAppbar(themeData, context, title: t.settings),
      backgroundColor: themeData.colorScheme.background,
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppValues.screenPadding),
                child: CustomText(
                    text: t.social, textStyleType: TextStyleType.subtitle2),
              ),
              const SizedBox(height: 10),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppValues.screenPadding),
                  child: Container(
                    decoration: BoxDecoration(
                        color: themeData.colorScheme.secondaryBgColor,
                        borderRadius:
                            BorderRadius.circular(AppValues.generalRadius)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SocialWidget(
                              themeData: themeData,
                              title: "GSMChina",
                              icon: Icons.telegram,
                              onTap: () {
                                urlLauncher("https://t.me/gsmchinacom");
                              },
                            ),
                            SocialWidget(
                              themeData: themeData,
                              title: "GSMChina Twitter",
                              icon: Icons.telegram,
                              onTap: () {
                                urlLauncher("https://twitter.com/gsmchinacom");
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SocialWidget(
                              themeData: themeData,
                              title: "Website",
                              icon: Icons.insert_link_rounded,
                              onTap: () {
                                urlLauncher("https://gsmchina.com");
                              },
                            ),
                            SocialWidget(
                              themeData: themeData,
                              title: t.share_with_fr,
                              icon: Icons.share_sharp,
                              onTap: () {
                                if (Platform.isAndroid) {
                                  Share.share(
                                      'https://play.google.com/store/apps/details?id=net.metareverse.voiceapp');
                                } else {
                                  Share.share(
                                      'https://apps.apple.com/app/voiceapp-celebrity-cloner/id6463164240');
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppValues.screenPadding),
                child: CustomText(
                    text: t.general, textStyleType: TextStyleType.subtitle2),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppValues.screenPadding),
                child: Container(
                  decoration: BoxDecoration(
                      color: themeData.colorScheme.secondaryBgColor,
                      borderRadius:
                          BorderRadius.circular(AppValues.generalRadius)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppValues.screenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: () {
                          urlLauncher(
                              'https://metareverse.net/apps/voice_cloning/privacy.html');
                        },
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        title: Text(
                          t.privacy_policy,
                          style: const TextStyle(fontSize: 15),
                        ),
                        horizontalTitleGap: 0,
                        leading: Icon(Icons.description_rounded,
                            color: themeData.colorScheme.primary, size: 22),
                      ),
                      ListTile(
                        onTap: () {
                          urlLauncher(
                              'https://metareverse.net/apps/voice_cloning/terms.html');
                        },
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        title: Text(
                          t.terms_of_service,
                          style: const TextStyle(fontSize: 15),
                        ),
                        horizontalTitleGap: 0,
                        leading: Icon(Icons.description_rounded,
                            color: themeData.colorScheme.primary, size: 22),
                      ),
                      ListTile(
                        onTap: () {
                          final Uri emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: 'info@metareverse.net',
                          );

                          launchUrl(emailLaunchUri);
                        },
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        title: Text(
                          t.contact_us,
                          style: const TextStyle(fontSize: 15),
                        ),
                        horizontalTitleGap: 0,
                        leading: Icon(Icons.email,
                            color: themeData.colorScheme.primary, size: 22),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget settingsList(BuildContext context, gleading, gtitle, gtrailing) {
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        title: gtitle,
        leading: gleading,
        trailing: gtrailing);
  }

  Widget settingsListInk(BuildContext context, gleading, gtitle, gtrailing) {
    return ListTile(
        onTap: () {},
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        title: gtitle,
        leading: gleading,
        trailing: gtrailing);
  }
}

class SocialWidget extends StatelessWidget {
  const SocialWidget({
    super.key,
    required this.themeData,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final ThemeData themeData;
  final IconData icon;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Icon(icon, color: themeData.colorScheme.primary),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: themeData.colorScheme.primaryTextColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
