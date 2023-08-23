import 'package:clone_voice/core/styles/custom_color_scheme.dart';
import 'package:clone_voice/core/styles/values.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const bgColor = Color(0xffffffff);
  static const secondaryBgColor = Color(0xfff6f4f5);
  static const secondaryBgColorLight = Color(0xfff1f2f3);
  static const secondaryBgColorDark = Color(0xffe7e7e7);
  static const primaryColor = Color(0xffff5353);
  static const secondaryColor = Color(0xff110637);
  static const buttonColor = Colors.black;

  static const dividerColor = Color(0xfff1f3f4);
  static const dividerTickColor = Color(0xffebedef);

  static const dividerAll = Color(0xffced7de);

  static const secondaryTextColor = Color(0xff66666B);
  static const secondaryTextColorDark = Color(0xff66666B);

  static const primaryTextColor = Color(0xff0f141a);

  static const bottomBarIconColor = Color(0xff66676c);

  static final shimmerBaseColor = Colors.grey.shade300;
  static final shimmerHighlightColor = Colors.grey.shade100;

  static const photoColor = Color(0xff19b2a6);
  static const pollColor = Color(0xfff5b400);
  static const videoColor = Color(0xff3b48df);

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

  static ButtonStyle elevatedStyle(
      {Color? color,
      bool? outlined,
      required ThemeData themeData,
      bool? active}) {
    return ButtonStyle(
      splashFactory: NoSplash.splashFactory,
      //visualDensity: VisualDensity.comfortable,
      textStyle: MaterialStateProperty.all(
          const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      backgroundColor: outlined == true
          ? MaterialStateProperty.all<Color>(Colors.transparent)
          : MaterialStateProperty.all<Color>(active == false
              ? themeData.colorScheme.secondaryBgColor
              : color ?? themeData.colorScheme.primary),
      elevation: MaterialStateProperty.all(0),
      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
          horizontal: AppValues.screenPadding * 2, vertical: 5)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            side: outlined == true
                ? BorderSide(color: color ?? themeData.primaryColor)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
      ),
    );
  }

  static ButtonStyle elevatedBorderStyle(ThemeData themeData,
      {Color? backgroundColor}) {
    return ButtonStyle(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minimumSize: MaterialStateProperty.all(Size.zero),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      elevation: MaterialStateProperty.all(0),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(
            horizontal: AppValues.screenPadding, vertical: 5),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            side: BorderSide(color: backgroundColor ?? themeData.primaryColor),
            borderRadius: BorderRadius.circular(50)),
      ),
    );
  }

  static createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
