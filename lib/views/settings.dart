import 'package:clone_voice/core/styles/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/styles/colors.dart';
import '../core/styles/values.dart';
import '../custom_text.dart';
import '../main.dart';
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

    return Scaffold(
      appBar: mainAppbar(themeData, context),
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
              const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
                child: CustomText(
                    text: "Social", textStyleType: TextStyleType.subtitle2),
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
                              title: "Share with Friends",
                              icon: Icons.share_sharp,
                              onTap: () {
                                urlLauncher("https://gsmchina.com");
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 15),
              const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
                child: CustomText(
                    text: "General", textStyleType: TextStyleType.subtitle2),
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
                          urlLauncher('https://gcamloader.com/privacy.html');
                        },
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        title: const Text(
                          "Privacy policy",
                          style: TextStyle(fontSize: 15),
                        ),
                        horizontalTitleGap: 0,
                        leading: Icon(Icons.description_rounded,
                            color: themeData.colorScheme.primary, size: 22),
                      ),
                      ListTile(
                        onTap: () {
                          urlLauncher('https://gcamloader.com/privacy.html');
                        },
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        title: const Text(
                          "Terms of Service",
                          style: TextStyle(fontSize: 15),
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
                        title: const Text(
                          "Contact Us",
                          style: TextStyle(fontSize: 15),
                        ),
                        horizontalTitleGap: 0,
                        leading: Icon(Icons.email,
                            color: themeData.colorScheme.primary, size: 22),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
                child: CustomText(
                    text: "Color Theme",
                    textStyleType: TextStyleType.subtitle2),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppValues.screenPadding),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: themeData.colorScheme.secondaryBgColor,
                      borderRadius:
                          BorderRadius.circular(AppValues.generalRadius)),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: AppValues.screenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            colorPicker(AppColors.primaryColor),
                            colorPicker(Colors.blue),
                            colorPicker(Colors.green),
                            colorPicker(Colors.teal),
                            colorPicker(Colors.purpleAccent),
                            colorPicker(Colors.yellow.shade900),
                            colorPicker(Colors.brown),
                          ],
                        ),
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

  Widget colorPicker(Color wcolor) {
    bool selected = (Theme.of(context).colorScheme.primary ==
        AppColors.createMaterialColor(wcolor));

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      margin: const EdgeInsets.only(right: 10),
      child: RawMaterialButton(
        shape: const CircleBorder(),
        elevation: 0,
        fillColor: wcolor,
        padding: const EdgeInsets.all(0.0),
        onPressed: () async {
          MyApp.of(context)!.changeColor(AppColors.createMaterialColor(wcolor));

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setInt("wcolor", wcolor.value);
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: selected
              ? const Icon(Icons.check_sharp, color: Colors.white)
              : null,
        ),
      ),
    );
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
              Text(
                title,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: themeData.colorScheme.primaryTextColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
