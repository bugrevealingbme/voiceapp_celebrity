import 'dart:io';

import 'package:clone_voice/core/constants/app_constants.dart';
import 'package:clone_voice/core/navigation/navigation_service.dart';
import 'package:clone_voice/views/custom_grey_error_page.dart';
import 'package:clone_voice/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/styles/colors.dart';
import 'core/styles/colors_dark.dart';
import 'globals.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

main() async {
  //fixs
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  PaintingBinding.instance.imageCache.maximumSizeBytes =
      1024 * 1024 * 8000; // 8000 MB
  await ScreenUtil.ensureScreenSize();

  MobileAds.instance.initialize();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  upgraded.value = prefs.getBool("upgraded") ?? false;

  //
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("535e15d0-73f7-41cf-94e8-74d57ebc4e23");
  OneSignal.shared.promptUserForPushNotificationPermission();
  //

  //color and theme
  ThemeMode themeMode = ThemeMode.system;

  //lang
  String appLang = 'en'; //await langBox.get('lang');
  appLang = prefs.getString("language") ?? Platform.localeName.substring(0, 2);
  //if lang not supported
  if (!AppConstants.supportedLocales.contains(Locale(appLang))) {
    appLang = 'en';
  }
  //

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(MyApp(
            locale: appLang,
            themeMode: themeMode,
          )));
}

class MyApp extends StatefulWidget {
  final ThemeMode themeMode;
  final String locale;

  const MyApp({
    Key? key,
    required this.themeMode,
    required this.locale,
  }) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();
}

class MyAppState extends State<MyApp> {
  ThemeMode? _themeMode;
  Locale? _locale;

  void changeTheme(ThemeMode lthemeMode) {
    setState(() {
      _themeMode = lthemeMode;
    });
  }

  setLocale(Locale value) async {
    setState(() {
      _locale = value;
    });
    if (_locale != null) {
      await AppLocalizations.delegate.load(_locale!);
    }
  }

  setStateState() async {
    setState(() {});
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            builder: (BuildContext context, Widget? widget) {
              ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                return CustomError(errorDetails: errorDetails);
              };
              return widget!;
            },
            title: 'VoiceApp',
            debugShowCheckedModeBanner: false,
            themeMode: _themeMode ?? widget.themeMode,
            navigatorKey: NavigationService.navigatorKey,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppConstants.supportedLocales,
            locale: _locale ?? Locale(widget.locale),
            localeResolutionCallback: (
              locale,
              supportedLocales,
            ) {
              return locale;
            },
            theme: ThemeData(
              primarySwatch:
                  AppColors.createMaterialColor(AppColors.primaryColor),
              appBarTheme: const AppBarTheme(
                foregroundColor: Colors.white,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  systemStatusBarContrastEnforced: false,
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.light,
                ),
              ),
              colorScheme: ColorScheme.fromSwatch(
                      primarySwatch:
                          AppColors.createMaterialColor(AppColors.primaryColor),
                      brightness: Brightness.light,
                      backgroundColor: AppColors.bgColor)
                  .copyWith(background: AppColors.bgColor),
              textTheme: const TextTheme(
                displayLarge: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryTextColor,
                ),
                displayMedium: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryTextColor,
                ),
                displaySmall: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryTextColor,
                ),
                titleSmall: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryTextColor,
                ),
                bodyLarge: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryTextColor,
                ),
                bodyMedium: TextStyle(
                  color: AppColors.primaryTextColor,
                ),
              ),
            ),
            darkTheme: ThemeData(
                primarySwatch:
                    AppColors.createMaterialColor(AppColorsDark.primaryColor),
                dividerColor: AppColorsDark.dividerAll,
                brightness: Brightness.dark,
                canvasColor: AppColorsDark.bgColor,
                appBarTheme: const AppBarTheme(
                  foregroundColor: AppColorsDark.bgColor,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    systemStatusBarContrastEnforced: false,
                    statusBarIconBrightness: Brightness.light,
                    statusBarBrightness: Brightness.dark,
                    systemNavigationBarColor: AppColorsDark.bgColor,
                  ),
                ),
                textTheme: const TextTheme(
                  displayLarge: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColorsDark.primaryTextColor,
                  ),
                  displayMedium: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColorsDark.primaryTextColor,
                  ),
                  displaySmall: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColorsDark.primaryTextColor,
                  ),
                  titleSmall: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppColorsDark.secondaryTextColor,
                  ),
                  bodyLarge: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColorsDark.primaryTextColor,
                  ),
                  bodyMedium: TextStyle(
                    color: AppColorsDark.primaryTextColor,
                  ),
                ),
                colorScheme: ColorScheme.fromSwatch(
                        primarySwatch: AppColors.createMaterialColor(
                            AppColorsDark.primaryColor),
                        brightness: Brightness.dark,
                        backgroundColor: AppColorsDark.bgColor)
                    .copyWith(background: AppColorsDark.bgColor)),
            home: const MainView(),
          );
        });
  }
}
