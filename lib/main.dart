import 'dart:io';

import 'package:clone_voice/views/custom_grey_error_page.dart';
import 'package:clone_voice/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

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

  SharedPreferences prefs = await SharedPreferences.getInstance();
  upgraded.value = prefs.getBool("upgraded") ?? false;

  //
  OneSignal.Debug.setLogLevel(OSLogLevel.none);
  OneSignal.initialize("535e15d0-73f7-41cf-94e8-74d57ebc4e23");
  OneSignal.Notifications.requestPermission(true);
  //

  //color and theme
  MaterialColor primaryColor =
      AppColors.createMaterialColor(AppColors.primaryColor);
  ThemeMode themeMode = ThemeMode.system;

  primaryColor = AppColors.createMaterialColor(
      Color(prefs.getInt("wcolor") ?? AppColors.primaryColor.value));
  //

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(MyApp(
            themeMode: themeMode,
            primaryColor: primaryColor,
          )));
}

class MyApp extends StatefulWidget {
  final ThemeMode themeMode;
  final MaterialColor primaryColor;

  const MyApp({Key? key, required this.themeMode, required this.primaryColor})
      : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();
}

class MyAppState extends State<MyApp> {
  ThemeMode? _themeMode;
  MaterialColor? _primaryColor;

  void changeTheme(ThemeMode lthemeMode) {
    setState(() {
      _themeMode = lthemeMode;
    });
  }

  void changeColor(MaterialColor lprimaryColor) {
    setState(() {
      _primaryColor = lprimaryColor;
    });
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
            title: 'VoiceApp: Celebrity',
            debugShowCheckedModeBanner: false,
            themeMode: _themeMode ?? widget.themeMode,
            theme: ThemeData(
              primarySwatch: _primaryColor ?? widget.primaryColor,
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
                      primarySwatch: _primaryColor ?? widget.primaryColor,
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
                primarySwatch: _primaryColor ?? widget.primaryColor,
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
                        primarySwatch: _primaryColor ?? widget.primaryColor,
                        brightness: Brightness.dark,
                        backgroundColor: AppColorsDark.bgColor)
                    .copyWith(background: AppColorsDark.bgColor)),
            home: const MainView(),
          );
        });
  }
}
