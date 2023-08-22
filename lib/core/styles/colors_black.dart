import 'package:flutter/material.dart';

class AppColorsBlack {
  static const bgColor = Color(0xff000000);
  static const secondaryBgColor = Color(0xff111111);
  static const secondaryBgColorLight = Color(0xff0e0d0c);
  static const secondaryBgColorDark = Color(0xff181818);
  static const primaryColor = Color(0xff008fff);

  static const secondaryTextColor = Color(0xff8b949e);
  static const secondaryTextColorDark = Color(0xff999994);

  static const primaryTextColor = Color(0xffc9d1d9);

  static const bottomBarIconColor = Color(0xff66676c);

  static final shimmerBaseColor = Colors.grey.shade700;
  static final shimmerHighlightColor = Colors.grey.shade500;

  static const articleColor = Color(0xff2865ca);
  static const questionColor = Colors.redAccent;
  static const developmentColor = Color.fromRGBO(56, 142, 60, 1);
  static const guideColor = Color(0xff2570E7);
  static const themeAppsModsColor = Color.fromRGBO(255, 145, 0, 1);
  static const accessoriesColor = Color.fromRGBO(249, 168, 37, 1);

  static const photoColor = Color(0xff19b2a6);
  static const pollColor = Color(0xfff5b400);
  static const videoColor = Color(0xff3b48df);

  static const createdUserColor = Color(0xfff0c400);

  static List<Color> lvlColors = const [
    Color(0xffffa200),
    Color(0xffee1224),
    Color(0xff01a7f8),
    Color(0xff2ab900),
    Color(0xff4401a5),
    Color(0xffe82bda),
    Color(0xff343f7c),
    Color(0xff4a4562)
  ];

  static Color lighten(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var p = percent / 100;
    return Color.fromARGB(
        c.alpha,
        c.red + ((255 - c.red) * p).round(),
        c.green + ((255 - c.green) * p).round(),
        c.blue + ((255 - c.blue) * p).round());
  }

  static Color darken(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(),
        (c.blue * f).round());
  }

  static Color invert(Color color) {
    final r = 255 - color.red;
    final g = 255 - color.green;
    final b = 255 - color.blue;

    return Color.fromARGB((color.opacity * 255).round(), r, g, b);
  }
}
