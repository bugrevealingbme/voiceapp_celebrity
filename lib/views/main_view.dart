import 'dart:io';

import 'package:clone_voice/core/styles/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/base_view.dart';
import '../core/constants/image_paths.dart';
import '../core/styles/sizes.dart';
import '../view_model/main_view_model/main_view_model.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<MainViewModel>(
      viewModel: MainViewModel(),
      onModelReady: (model) {
        model.init();
        model.setContext(context);
      },
      onDispose: (model) => model.dispose(),
      onPageBuilder: (context, viewModel, t, themeData) => Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          extendBodyBehindAppBar: true,
          key: viewModel.scaffoldKey,
          backgroundColor: themeData.colorScheme.background,
          body: Observer(
            builder: (_) {
              return IndexedStack(
                index: viewModel.currentIndex,
                children: viewModel.viewList,
              );
            },
          ),
          bottomNavigationBar:
              buildBottomAppBar(context, themeData, viewModel)),
    );
  }

  Widget buildBottomAppBar(
      BuildContext context, ThemeData themeData, MainViewModel viewModel) {
    return Container(
      height: kBottomNavigationBarHeight +
          (Platform.isIOS
              ? ScreenUtil().bottomBarHeight / 1.3
              : ScreenUtil().bottomBarHeight) +
          (AppSizes().useTabletLayout == true
              ? (kBottomNavigationBarHeight / 1.11)
              : 0),
      padding: EdgeInsets.only(
          bottom: Platform.isIOS ? ScreenUtil().bottomBarHeight / 1.7 : 0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: themeData.colorScheme.background,
        border: Border(
          top: BorderSide(
              color: themeData.colorScheme.dividerTickColor, width: 0.5),
        ),
      ),
      child: Observer(builder: (_) {
        return Row(
          key: UniqueKey(),
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            bottomNavItem(
              themeData,
              ImagePaths.bHome,
              ImagePaths.bHome,
              "Home",
              viewModel.currentIndex == 0,
              onTap: () => viewModel.updateCurrentIndex(0),
            ),
            bottomNavItem(
              themeData,
              ImagePaths.bNews,
              ImagePaths.bNews,
              "News",
              viewModel.currentIndex == 1,
              onTap: () => viewModel.updateCurrentIndex(1),
            ),
            bottomNavItem(
              themeData,
              ImagePaths.bSettings,
              ImagePaths.bSettings,
              "Settings",
              viewModel.currentIndex == 2,
              onTap: () => viewModel.updateCurrentIndex(2),
              profile: true,
            ),
          ],
        );
      }),
    );
  }

  Widget bottomNavItem(
    ThemeData themeData,
    String path,
    String activePath,
    String text,
    bool selected, {
    Function()? onLongPress,
    Function()? onTap,
    int? badge,
    IconData? icon,
    bool? profile,
    MainViewModel? viewModel,
  }) {
    final double iconWidth = ScreenUtil().screenWidth *
        (AppSizes().useTabletLayout == true ? .03 : .0533);

    return Expanded(
      child: InkWell(
        splashColor: Colors.transparent,
        onLongPress: onLongPress,
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                icon != null
                    ? Icon(
                        icon,
                        color: selected
                            ? themeData.colorScheme.primaryTextColor
                            : themeData.colorScheme.secondaryTextColor,
                      )
                    : Image.asset(
                        selected ? activePath : path,
                        filterQuality: FilterQuality.high,
                        cacheWidth: (iconWidth * (ScreenUtil().pixelRatio ?? 1))
                            .round(),
                        width: iconWidth,
                        color: selected
                            ? themeData.colorScheme.primary
                            : themeData.colorScheme.secondaryTextColor,
                      ),
                if (badge != null && badge > 0)
                  Positioned(
                    right: -12.721,
                    top: -7,
                    child: ClipOval(
                      //two container for border
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              width: 2,
                              color: themeData.colorScheme.background),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              badge.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            /* const SizedBox(height: 5),
            Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: selected
                    ? themeData.colorScheme.primary
                    : themeData.colorScheme.secondaryTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 0,
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
