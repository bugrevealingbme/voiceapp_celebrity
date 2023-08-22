import 'package:clone_voice/core/styles/custom_color_scheme.dart';
import 'package:clone_voice/globals.dart';
import 'package:clone_voice/views/share_view.dart';
import 'package:clone_voice/views/upgrade_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../core/base_view.dart';
import '../core/styles/values.dart';
import '../main_appbar.dart';
import '../models/event_data.dart';
import '../models/list_data.dart';
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
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            reverse: true,
            child: Column(
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
                                text: "Woman",
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Observer(builder: (_) {
                        return GridView.builder(
                          shrinkWrap: true,
                          itemCount: viewModel.celebrities.length,
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 15,
                          ),
                          itemBuilder: (context, index) {
                            return Observer(builder: (_) {
                              String? gender;
                              if (viewModel.tabIndex == 1) {
                                gender = "male";
                              } else if (viewModel.tabIndex == 2) {
                                gender = "woman";
                              } else {
                                gender = null;
                              }

                              if (gender != null &&
                                  gender !=
                                      viewModel.celebrities[index]['gender']) {
                                return const SizedBox();
                              }

                              return InkWell(
                                borderRadius: BorderRadius.circular(50),
                                splashColor: Colors.transparent,
                                onTap: () {
                                  viewModel.selectedId =
                                      viewModel.celebrities[index]['id'];
                                },
                                child: Column(
                                  children: [
                                    Flexible(
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 100),
                                        padding:
                                            EdgeInsets.all(index == 0 ? 2 : 2),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              color: viewModel.selectedId ==
                                                      viewModel.celebrities[
                                                          index]['id']
                                                  ? themeData
                                                      .colorScheme.primary
                                                  : Colors.transparent,
                                              width: 2),
                                        ),
                                        child: ClipOval(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                colorFilter: ColorFilter.mode(
                                                    Colors.black
                                                        .withOpacity(0.9721),
                                                    BlendMode.dstATop),
                                                alignment: Alignment.center,
                                                image: NetworkImage(
                                                  viewModel.celebrities[index]
                                                      ['img'],
                                                ),
                                                fit: BoxFit.cover,
                                              ),
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
                      }),
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
                /* ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Icon(
                      Icons.translate_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ), */

                Padding(
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
                      onPressed: () async {
                        Navigator.push(
                            viewModel.lcontext,
                            MaterialPageRoute(
                              builder: (context) => const GeneratingView(),
                            ));

                        final EventData? eventData = await viewModel.postTTS();
                        if (eventData == null) {
                          Future.delayed(
                            Duration.zero,
                            () {
                              Navigator.pop(context);
                            },
                          );

                          Fluttertoast.showToast(
                            msg: "An error has occurred.",
                          );

                          return;
                        }

                        Future.delayed(
                          Duration.zero,
                          () {
                            Person person = Person.fromJson(
                                viewModel.celebrities.firstWhere((element) =>
                                    element['id'] == viewModel.selectedId));

                            return Navigator.pushReplacement(
                                viewModel.lcontext,
                                MaterialPageRoute(
                                  builder: (context) => ShareView(
                                    eventData: eventData,
                                    text: viewModel.textController.text,
                                    person: person,
                                  ),
                                ));
                          },
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Generate",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          Icon(Icons.chevron_right_outlined, size: 18),
                        ],
                      ),
                    ),
                  ),
                ),
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
