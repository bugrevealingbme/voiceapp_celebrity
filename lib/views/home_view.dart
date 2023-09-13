import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clone_voice/core/styles/colors.dart';
import 'package:clone_voice/core/styles/custom_color_scheme.dart';
import 'package:clone_voice/globals.dart';
import 'package:clone_voice/models/langs_model.dart';
import 'package:clone_voice/utils.dart';
import 'package:clone_voice/utils/empty_behavior.dart';
import 'package:clone_voice/views/share_view.dart';
import 'package:clone_voice/views/upgrade_view.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../core/base_view.dart';
import '../core/styles/values.dart';
import '../main_appbar.dart';
import '../models/event_data.dart';
import '../models/person_model.dart';
import '../view_model/home_view_model/home_view_model.dart';
import 'generating.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      viewModel: HomeViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onDispose: (model) => model.dispose(),
      onPageBuilder: (context, viewModel, t, themeData) => Scaffold(
        backgroundColor: themeData.colorScheme.background,
        appBar: mainAppbar(themeData, context),
        body: DefaultTabController(
          length: 4,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppValues.screenPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Theme(
                        data: ThemeData(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              TabBar(
                                labelColor:
                                    themeData.colorScheme.primaryTextColor,
                                indicator: BoxDecoration(
                                  color: themeData.colorScheme.secondaryBgColor,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                isScrollable: true,
                                physics: const ScrollPhysics(),
                                indicatorPadding: EdgeInsets.zero,
                                padding: EdgeInsets.zero,
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 13, vertical: 0),
                                labelStyle: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                                unselectedLabelColor:
                                    themeData.colorScheme.secondaryTextColor,
                                onTap: (value) {
                                  viewModel.tabIndex = value;
                                },
                                tabs: [
                                  Tab(
                                    text: t.all,
                                  ),
                                  Tab(
                                    text: t.male,
                                  ),
                                  Tab(
                                    text: t.female,
                                  ),
                                  const Tab(
                                    text: "CGI",
                                  )
                                ],
                              ),
                              const Spacer(),
                              Observer(builder: (_) {
                                return InkWell(
                                  onTap: () =>
                                      viewModel.volumeUp = !viewModel.volumeUp,
                                  child: Icon(
                                    viewModel.volumeUp == true
                                        ? Icons.volume_up_outlined
                                        : Icons.volume_off_outlined,
                                    color:
                                        themeData.colorScheme.primaryTextColor,
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      MyPopupMenu(
                        viewModel: viewModel,
                        child: Container(
                          key: GlobalKey(),
                          foregroundDecoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                themeData.colorScheme.background
                                    .withOpacity(0.001),
                                themeData.colorScheme.background
                                    .withOpacity(0.001),
                                themeData.colorScheme.background.withOpacity(1),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(
                              maxHeight: ScreenUtil().screenHeight * .1721),
                          child: getGridView(viewModel, themeData),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppValues.screenPadding),
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeData.colorScheme.secondaryBgColor,
                      border: Border.all(
                          color: themeData.colorScheme.secondaryBgColorDark),
                      borderRadius:
                          BorderRadius.circular(AppValues.generalRadius),
                    ),
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: viewModel.textController,
                      autofocus: false,
                      showCursor: true,
                      scrollPadding: EdgeInsets.zero,
                      expands: false,
                      maxLength: 300,
                      textCapitalization: TextCapitalization.sentences,
                      enableInteractiveSelection: true,
                      scrollController: ScrollController(),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 6,
                      focusNode: FocusNode(),
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppValues.screenPadding, vertical: 15),
                        fillColor: themeData.colorScheme.secondaryBgColor,
                        hintText: t.home_input,
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: themeData.colorScheme.secondaryTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                        hintMaxLines: 4,
                        labelStyle: const TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              BorderRadius.circular(AppValues.generalRadius),
                          gapPadding: 10,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0, color: Colors.transparent),
                          borderRadius:
                              BorderRadius.circular(AppValues.generalRadius),
                          gapPadding: 10,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Observer(builder: (_) {
                  return viewModel.appModded == true
                      ? Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Invalid Version"),
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      themeData.colorScheme.primary),
                                  elevation: MaterialStateProperty.all(0),
                                ),
                                onPressed: () async {
                                  await urlLauncher(
                                      'https://play.google.com/store/apps/details?id=net.metareverse.voiceapp');
                                },
                                child: const Text(
                                  "Play Store",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : ValueListenableBuilder(
                          valueListenable: upgraded,
                          builder: (context, bool upgraded, child) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppValues.screenPadding),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        themeData.colorScheme.buttonColor,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 17),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: () async {
                                    if (upgraded != true) {
                                      final bool? willgenerate =
                                          await Navigator.push(
                                              viewModel.lcontext,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const UpgradeView(
                                                        showAdB: true),
                                              ));

                                      if (willgenerate != true) {
                                        return;
                                      }
                                    }

                                    Future.delayed(
                                      Duration.zero,
                                      () {
                                        Navigator.push(
                                            viewModel.lcontext,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const GeneratingView(),
                                            ));

                                        viewModel
                                            .postTTS()
                                            .then((EventData? eventData) {
                                          if (eventData == null) {
                                            Navigator.pop(context);

                                            Fluttertoast.showToast(
                                              msg: "An error has occurred.",
                                            );

                                            return null;
                                          }

                                          if (viewModel.celebrities == null) {
                                            return null;
                                          }

                                          PersonModel person = viewModel
                                              .celebrities!
                                              .firstWhere((element) =>
                                                  (element.id ?? '')
                                                      .toString() ==
                                                  viewModel.selectedId);

                                          return Navigator.pushReplacement(
                                              viewModel.lcontext,
                                              MaterialPageRoute(
                                                builder: (context) => ShareView(
                                                  eventData: eventData,
                                                  text: viewModel
                                                      .textController.text,
                                                  person: person,
                                                ),
                                              ));
                                        });
                                      },
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        t.generate,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: AppColors.invert(themeData
                                                .colorScheme.primaryTextColor)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                }),
                const SizedBox(height: 25),
                ValueListenableBuilder(
                    valueListenable: upgraded,
                    builder: (context, bool upgraded, child) {
                      return upgraded
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppValues.screenPadding),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const UpgradeView(),
                                      ));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            t.upgrade_to_voice_pro,
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: themeData
                                                  .colorScheme.primaryTextColor,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            t.discover_unlimited_pos,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: themeData.colorScheme
                                                    .secondaryTextColor),
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Container(
                                      padding: const EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.33,
                                            color: themeData
                                                .colorScheme.secondaryColor),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Icon(Icons.upgrade_rounded,
                                          color: themeData
                                              .colorScheme.secondaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            );
                    }),
                Observer(builder: (_) {
                  if (viewModel.tipTexts.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppValues.screenPadding),
                      child: Column(
                        children: [
                          ValueListenableBuilder(
                              valueListenable: upgraded,
                              builder: (context, bool upgraded, child) {
                                return upgraded
                                    ? const SizedBox(height: 25)
                                    : const Divider(height: 35);
                              }),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppValues.generalRadius / 2.22),
                                border: Border.all(
                                  color: themeData.colorScheme.secondaryBgColor,
                                )),
                            child: ExpandablePageView.builder(
                              itemCount: viewModel.tipTexts.length,
                              scrollDirection: Axis.horizontal,
                              controller: viewModel.pageCont,
                              padEnds: false,
                              physics: const BouncingScrollPhysics(),
                              animateFirstPage: true,
                              itemBuilder: (context, i) {
                                return Row(
                                  children: [
                                    if (i == 0) ...[
                                      const Icon(
                                        Icons.tips_and_updates_outlined,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 15),
                                    ],
                                    Flexible(
                                      child: Text(
                                        viewModel.tipTexts[
                                            i % viewModel.tipTexts.length],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          SmoothPageIndicator(
                            controller: viewModel.pageCont,
                            count: viewModel.tipTexts.length,
                            effect: WormEffect(
                                dotHeight: 5,
                                dotWidth: 5,
                                type: WormType.normal,
                                activeDotColor:
                                    themeData.colorScheme.buttonColor),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                }),
                const SizedBox(height: kBottomNavigationBarHeight + 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget getGridView(HomeViewModel viewModel, ThemeData themeData,
    {bool? physc, Function()? close}) {
  return Observer(builder: (_) {
    List<PersonModel> temp = [];
    temp.addAll(viewModel.celebrities ?? []);

    String? gender;

    if (viewModel.tabIndex == 1) {
      gender = "male";
    } else if (viewModel.tabIndex == 2) {
      gender = "female";
    } else if (viewModel.tabIndex == 3) {
      gender = "cgi";
    } else {
      gender = null;
    }

    if (gender != null) {
      temp.removeWhere((element) => element.gender != gender);
    }

    if (viewModel.selectedLang != '') {
      String langCode = viewModel.selectedLang;
      temp.removeWhere((element) => element.langCode != langCode);
    }

    return ListView.builder(
      shrinkWrap: true,
      controller: viewModel.gridController,
      padding: physc == true
          ? const EdgeInsets.symmetric(vertical: 20)
          : EdgeInsets.zero,
      primary: false,
      itemCount: temp.isEmpty ? 1 : temp.length,
      physics: physc == true
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (temp.isEmpty) {
          return Icon(
            Icons.search_off_outlined,
            color: themeData.colorScheme.secondaryTextColor,
            size: 38,
          );
        }

        return Observer(builder: (_) {
          PersonModel personModel = temp[index];
          return InkWell(
            borderRadius: BorderRadius.circular(50),
            splashColor: Colors.transparent,
            onTap: () {
              viewModel.scrollToIndex(index);
              if (close != null) {
                close();
              }
              viewModel.selectedId = personModel.id.toString();

              if (viewModel.volumeUp) {
                AssetsAudioPlayer.newPlayer().open(
                  Audio(
                      "assets/voices/${personModel.name?.replaceAll(' ', '_').toLowerCase()}.mp3"),
                  autoStart: true,
                  showNotification: false,
                  respectSilentMode: false,
                  playSpeed: 1,
                  loopMode: LoopMode.none,
                  volume: 1,
                );
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: viewModel.selectedId == personModel.id.toString()
                    ? themeData.colorScheme.secondaryBgColor
                    : null,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    width: 48,
                    height: 48,
                    duration: const Duration(milliseconds: 100),
                    padding: EdgeInsets.all(index == 0 ? 2 : 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(500),
                      border: Border.all(
                          color:
                              viewModel.selectedId == personModel.id.toString()
                                  ? themeData.colorScheme.primary
                                  : Colors.transparent,
                          width: 1.5),
                    ),
                    child: ClipOval(
                      child: Container(
                        decoration: BoxDecoration(
                          image:
                              personModel.img != null && personModel.img != ""
                                  ? DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.9721),
                                          BlendMode.dstATop),
                                      alignment: Alignment.center,
                                      image: CachedNetworkImageProvider(
                                        personModel.img ?? '',
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    personModel.fakeName ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  const SizedBox(width: 5),
                  Text(
                      viewModel.flags
                              .firstWhere(
                                (element) =>
                                    element.code == personModel.langCode,
                                orElse: () => LangsModel(),
                              )
                              .flag ??
                          '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      )),
                  const Spacer(),
                  Icon(Icons.keyboard_arrow_right_rounded,
                      color: themeData.colorScheme.secondaryTextColor),
                  const SizedBox(width: 7),
                ],
              ),
            ),
          );
        });
      },
    );
  });
}

class MyPopupMenu extends StatefulWidget {
  final Widget child;
  final HomeViewModel viewModel;
  final bool? click;

  MyPopupMenu(
      {Key? key, required this.child, required this.viewModel, this.click})
      : assert(child.key != null),
        super(key: key);

  @override
  MyPopupMenuState createState() => MyPopupMenuState();
}

class MyPopupMenuState extends State<MyPopupMenu> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (details) => _showPopupMenu(),
      onTap: widget.click == true ? () => _showPopupMenu() : null,
      child: widget.child,
    );
  }

  void _showPopupMenu() {
    //Find renderbox object
    RenderBox renderBox = (widget.child.key as GlobalKey)
        .currentContext
        ?.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);

    showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return PopupMenuContent(
            position: position,
            size: renderBox.size,
            viewModell: widget.viewModel,
          );
        });
  }
}

class PopupMenuContent extends StatefulWidget {
  final Offset position;
  final Size size;
  final ValueChanged<String>? onAction;
  final HomeViewModel viewModell;

  const PopupMenuContent(
      {Key? key,
      required this.position,
      required this.size,
      required this.viewModell,
      this.onAction})
      : super(key: key);

  @override
  PopupMenuContentState createState() => PopupMenuContentState();
}

class PopupMenuContentState extends State<PopupMenuContent>
    with SingleTickerProviderStateMixin {
  //Let's create animation
  late AnimationController _animationController;
  late Animation<double> _animation;
  late HomeViewModel viewModel;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 125));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animationController.forward();
    });

    viewModel = widget.viewModell;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        _closePopup();
        return false;
      },
      child: Material(
        type: MaterialType.transparency,
        child: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                top: 0,
                right: 0,
                child: InkWell(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () => _closePopup(),
                  child: Container(),
                ),
              ),
              Positioned(
                left: AppValues.screenPadding,
                right: AppValues.screenPadding,
                top: kToolbarHeight * 2.5,
                bottom: 15,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animation.value,
                      alignment: Alignment.topCenter,
                      child: Opacity(opacity: _animation.value, child: child),
                    );
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppValues.screenPadding),
                    decoration: BoxDecoration(
                        color: themeData.colorScheme.background,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.1),
                            blurRadius: 8,
                          )
                        ]),
                    child: ScrollConfiguration(
                        behavior: EmptyBehavior(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            /* Row(
                              children: [
                                DefaultTabController(
                                  length: 4,
                                  initialIndex: viewModel.tabIndex,
                                  child: Theme(
                                    data: ThemeData(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: TabBar(
                                        labelColor: themeData
                                            .colorScheme.primaryTextColor,
                                        indicator: BoxDecoration(
                                          color: themeData
                                              .colorScheme.secondaryBgColor,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        isScrollable: true,
                                        physics: const ScrollPhysics(),
                                        indicatorPadding: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        labelPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 0),
                                        labelStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                        unselectedLabelColor: themeData
                                            .colorScheme.secondaryTextColor,
                                        onTap: (value) {
                                          viewModel.tabIndex = value;
                                        },
                                        tabs: const [
                                          Tab(
                                            text: "All",
                                          ),
                                          Tab(
                                            text: "Male",
                                          ),
                                          Tab(
                                            text: "Female",
                                          ),
                                          Tab(
                                            text: "CGI",
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ), */
                            const SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Observer(builder: (_) {
                                    return InkWell(
                                      onTap: () {
                                        viewModel.selectedLang = '';
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                            milliseconds:
                                                AppValues.fastDuration),
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: viewModel.selectedLang == ''
                                              ? themeData
                                                  .colorScheme.secondaryBgColor
                                              : null,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: themeData.colorScheme
                                                  .secondaryBgColor),
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.clear_all_rounded)
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                  for (int i = 0;
                                      i < viewModel.flags.length;
                                      i++) ...[
                                    Observer(builder: (_) {
                                      return InkWell(
                                        onTap: () {
                                          viewModel.selectedLang =
                                              viewModel.flags[i].code ?? 'en';
                                        },
                                        child: AnimatedContainer(
                                          duration: const Duration(
                                              milliseconds:
                                                  AppValues.fastDuration),
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: viewModel.selectedLang ==
                                                    viewModel.flags[i].code
                                                ? themeData.colorScheme
                                                    .secondaryBgColor
                                                : null,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                color: themeData.colorScheme
                                                    .secondaryBgColor),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  viewModel.flags[i].flag ??
                                                      '🇺🇸',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  ]
                                ],
                              ),
                            ),
                            Flexible(
                              child: getGridView(viewModel, themeData,
                                  physc: true, close: _closePopup),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _closePopup() {
    _animationController.reverse().whenComplete(() {
      Navigator.of(context).pop();
    });
  }
}
