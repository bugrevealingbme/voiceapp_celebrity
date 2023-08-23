import 'package:flutter/material.dart';

import 'colors.dart';
import 'colors_dark.dart';

extension CustomColorScheme on ColorScheme {
  Color get primaryColorLite => brightness == Brightness.light
      ? AppColors.primaryColor.withOpacity(0.1)
      : AppColors.primaryColor.withOpacity(0.133);

  Color get buttonColor => brightness == Brightness.light
      ? AppColors.buttonColor
      : AppColorsDark.buttonColor;

  Color get secondaryBgColor => brightness == Brightness.light
      ? AppColors.secondaryBgColor
      : AppColorsDark.secondaryBgColor;

  Color get secondaryBgColorLight => brightness == Brightness.light
      ? AppColors.secondaryBgColorLight
      : AppColorsDark.secondaryBgColorLight;

  Color get secondaryBgColorDark => brightness == Brightness.light
      ? AppColors.secondaryBgColorDark
      : AppColorsDark.secondaryBgColorDark;

  Color get dividerAllColor => brightness == Brightness.light
      ? AppColors.dividerAll
      : AppColorsDark.dividerAll;

  Color get dividerColor => brightness == Brightness.light
      ? AppColors.dividerColor
      : AppColorsDark.dividerColor;

  Color get dividerTickColor => brightness == Brightness.light
      ? AppColors.dividerTickColor
      : AppColorsDark.dividerTickColor;

  Color get primaryTextColor => brightness == Brightness.light
      ? AppColors.primaryTextColor
      : AppColorsDark.primaryTextColor;

  Color get secondaryTextColor => brightness == Brightness.light
      ? AppColors.secondaryTextColor
      : AppColorsDark.secondaryTextColor;

  Color get secondaryColor => brightness == Brightness.light
      ? AppColors.secondaryColor
      : AppColorsDark.secondaryColor;

  Color get secondaryTextColorDark => brightness == Brightness.light
      ? AppColors.secondaryTextColorDark
      : AppColorsDark.secondaryTextColorDark;

  Color get bottomBarIconColor => brightness == Brightness.light
      ? AppColors.bottomBarIconColor
      : AppColorsDark.bottomBarIconColor;

  Color get shimmerBaseColor => brightness == Brightness.light
      ? AppColors.shimmerBaseColor
      : AppColorsDark.shimmerBaseColor;

  Color get shimmerHighlightColor => brightness == Brightness.light
      ? AppColors.shimmerHighlightColor
      : AppColorsDark.shimmerHighlightColor;
}
