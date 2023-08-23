import 'package:clone_voice/core/styles/custom_color_scheme.dart';
import 'package:clone_voice/core/styles/sizes.dart';
import 'package:clone_voice/globals.dart';
import 'package:clone_voice/utils.dart';
import 'package:clone_voice/utils/empty_behavior.dart';
import 'package:clone_voice/views/share_view.dart';
import 'package:clone_voice/views/upgrade_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../core/base_view.dart';
import '../core/styles/values.dart';
import '../main_appbar.dart';
import '../models/event_data.dart';
import '../models/person_model.dart';
import '../utils/upper_case_text_formatter.dart';
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
      onPageBuilder: (context, viewModel, themeData) => Scaffold(
        backgroundColor: themeData.colorScheme.background,
        appBar: mainAppbar(themeData, context),
        body: DefaultTabController(
          length: 3,
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            //reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
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
                          child: TabBar(
                            labelColor: themeData.colorScheme.primaryTextColor,
                            indicator: BoxDecoration(
                              color: themeData.colorScheme.secondaryBgColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            isScrollable: true,
                            physics: const ScrollPhysics(),
                            indicatorPadding: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            labelPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 0),
                            labelStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                            unselectedLabelColor:
                                themeData.colorScheme.secondaryTextColor,
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
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      MyPopupMenu(
                        viewModel: viewModel,
                        child: Container(
                          key: GlobalKey(),
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.zero,
                          constraints:
                              BoxConstraints(maxHeight: AppSizes.height15),
                          child: Observer(builder: (context) {
                            return getGridView(viewModel, themeData);
                          }),
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
                      inputFormatters: <TextInputFormatter>[
                        UpperCaseTextFormatter()
                      ],
                      enableInteractiveSelection: true,
                      scrollController: ScrollController(),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 6,
                      focusNode: FocusNode(),
                      decoration: InputDecoration(
                        helperText: "Only english",
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppValues.screenPadding, vertical: 15),
                        fillColor: themeData.colorScheme.secondaryBgColor,
                        hintText:
                            "Type your text here, selected will say it for you",
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
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppValues.screenPadding),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppValues.generalRadius * 1.111),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
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
                                  }

                                  if (viewModel.celebrities == null) {
                                    return null;
                                  }

                                  PersonModel person = viewModel.celebrities!
                                      .firstWhere((element) =>
                                          (element.id ?? '').toString() ==
                                          viewModel.selectedId);

                                  return Navigator.pushReplacement(
                                      viewModel.lcontext,
                                      MaterialPageRoute(
                                        builder: (context) => ShareView(
                                          eventData: eventData ?? EventData(),
                                          text: viewModel.textController.text,
                                          person: person,
                                        ),
                                      ));
                                });
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Generate",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Icon(Icons.chevron_right_outlined, size: 18),
                                ],
                              ),
                            ),
                          ),
                        );
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
                                            "Upgrade to VoiceAPP Pro",
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: themeData
                                                  .colorScheme.primaryTextColor,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "Discover unlimited possibilities now!",
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
                                            color:
                                                themeData.colorScheme.primary),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Icon(Icons.upgrade_rounded,
                                          color: themeData.colorScheme.primary),
                                    ),
                                  ],
                                ),
                              ),
                            );
                    }),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

GridView getGridView(HomeViewModel viewModel, ThemeData themeData,
    {bool? physc}) {
  return GridView.builder(
    shrinkWrap: true,
    padding: physc == true
        ? const EdgeInsets.symmetric(vertical: 20)
        : EdgeInsets.zero,
    primary: false,
    itemCount: viewModel.celebrities?.length ?? 0,
    physics: physc == true
        ? const BouncingScrollPhysics()
        : const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      crossAxisSpacing: 5,
      mainAxisSpacing: 0,
    ),
    itemBuilder: (context, index) {
      return Observer(builder: (_) {
        String? gender;
        if (viewModel.tabIndex == 1) {
          gender = "male";
        } else if (viewModel.tabIndex == 2) {
          gender = "female";
        } else {
          gender = null;
        }

        if (gender != null && gender != viewModel.celebrities?[index].gender) {
          return Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent, width: 2),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: themeData.colorScheme.secondaryBgColorLight,
              ),
            ),
          );
        }

        return InkWell(
          borderRadius: BorderRadius.circular(50),
          splashColor: Colors.transparent,
          onTap: () {
            viewModel.selectedId =
                viewModel.celebrities?[index].id.toString() ?? '';
          },
          child: Column(
            children: [
              Flexible(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  padding: EdgeInsets.all(index == 0 ? 2 : 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                        color: viewModel.selectedId ==
                                viewModel.celebrities?[index].id.toString()
                            ? themeData.colorScheme.primary
                            : Colors.transparent,
                        width: 2),
                  ),
                  child: ClipOval(
                    child: Container(
                      decoration: BoxDecoration(
                        image: viewModel.celebrities?[index].img != null &&
                                viewModel.celebrities?[index].img != ""
                            ? DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.9721),
                                    BlendMode.dstATop),
                                alignment: Alignment.center,
                                image: NetworkImage(
                                  viewModel.celebrities?[index].img ?? '',
                                ),
                                fit: BoxFit.cover,
                              )
                            : null,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
    },
  );
}

class MyPopupMenu extends StatefulWidget {
  final Widget child;
  final HomeViewModel viewModel;

  MyPopupMenu({Key? key, required this.child, required this.viewModel})
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
        child: InkWell(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () => _closePopup(),
          child: SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Stack(
              children: [
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
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppValues.screenPadding),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.1),
                                blurRadius: 8,
                              )
                            ]),
                        child: ScrollConfiguration(
                            behavior: EmptyBehavior(),
                            child:
                                getGridView(viewModel, themeData, physc: true)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
