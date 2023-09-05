import 'dart:io';
import 'dart:math';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:clone_voice/core/styles/colors.dart';
import 'package:clone_voice/core/styles/custom_color_scheme.dart';
import 'package:clone_voice/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../core/base_view.dart';
import '../core/styles/values.dart';
import '../models/event_data.dart';
import '../models/person_model.dart';
import '../view_model/share_view_model/share_view_model.dart';

class ShareView extends StatelessWidget {
  final String text;
  final EventData eventData;
  final PersonModel person;

  const ShareView(
      {super.key,
      required this.eventData,
      required this.text,
      required this.person});

  @override
  Widget build(BuildContext context) {
    return BaseView<ShareViewModel>(
      viewModel: ShareViewModel(),
      onModelReady: (model) {
        model.eventData = eventData;
        model.setContext(context);
        model.init();
      },
      onDispose: (model) => model.dispose(),
      onPageBuilder: (context, viewModel, themeData) => Scaffold(
        backgroundColor: themeData.colorScheme.background,
        appBar: AppBar(
          elevation: 0,
          titleSpacing: AppValues.screenPadding,
          backgroundColor: themeData.colorScheme.background,
          actionsIconTheme:
              IconThemeData(color: themeData.colorScheme.primaryTextColor),
          iconTheme:
              IconThemeData(color: themeData.colorScheme.primaryTextColor),
          title: const Text('Result'),
          titleTextStyle: TextStyle(
              color: themeData.colorScheme.primaryTextColor,
              fontWeight: FontWeight.w900,
              fontSize: 24),
          toolbarTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: themeData.colorScheme.secondaryColor,
          ),
        ),
        body: DefaultTabController(
          length: 5,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppValues.screenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: SizedBox(
                          width: 48,
                          height: 48,
                          child: Image.network(person.img ?? '',
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    themeData.colorScheme.secondaryBgColorDark),
                            borderRadius:
                                BorderRadius.circular(AppValues.generalRadius),
                          ),
                          child: Text(
                            text,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Observer(builder: (context) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            onPressed: () {
                              HapticFeedback.lightImpact();

                              viewModel.isPlaying == true
                                  ? viewModel.controller.pausePlayer()
                                  : viewModel.controller.startPlayer(
                                      finishMode: FinishMode.pause,
                                      forceRefresh: true);

                              return;
                            },
                            icon: Icon(
                              viewModel.isPlaying == true
                                  ? Icons.stop
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: 30,
                            ),
                            color: Colors.black,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                        );
                      }),
                      const SizedBox(width: 25),
                      Expanded(
                        child: AudioFileWaveforms(
                          size: Size(
                              MediaQuery.of(context).size.width / 2, 100.0),
                          playerController: viewModel.controller,
                          waveformType: WaveformType.long,
                          waveformData: viewModel.waveformData,
                          playerWaveStyle: PlayerWaveStyle(
                            fixedWaveColor: Colors.black,
                            liveWaveColor: themeData.colorScheme.secondaryColor,
                            seekLineColor: AppColors.invert(
                                    themeData.colorScheme.background)
                                .withOpacity(0.11),
                            seekLineThickness: 1.721,
                            spacing: 6,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const CustomText(
                      text: "More", textStyleType: TextStyleType.headline25),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          borderRadius:
                              BorderRadius.circular(AppValues.generalRadius),
                          onTap: () async {
                            if (viewModel.audioFile == null) {
                              return;
                            }

                            Directory? appDocumentsDirectory;

                            if (Platform.isIOS) {
                              appDocumentsDirectory =
                                  await getApplicationDocumentsDirectory();
                            } else {
                              appDocumentsDirectory =
                                  Directory('/storage/emulated/0/Download');
                              // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
                              // ignore: avoid_slow_async_io
                              if (!await appDocumentsDirectory.exists()) {
                                appDocumentsDirectory =
                                    await getExternalStorageDirectory();
                              }
                            }

                            String? appDocumentsPath =
                                appDocumentsDirectory?.path;

                            final String fileName =
                                '${person.name}${Random().nextInt(999)}.mp3';

                            File('$appDocumentsPath/$fileName').writeAsBytes(
                                viewModel.audioFile!.readAsBytesSync());

                            Fluttertoast.showToast(
                              msg: "Sound saved",
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                              color: themeData.colorScheme.secondaryBgColorDark,
                              borderRadius: BorderRadius.circular(
                                  AppValues.generalRadius),
                            ),
                            child: const Column(
                              children: [
                                Icon(Icons.download_rounded),
                                SizedBox(height: 10),
                                Text(
                                  "Save",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: InkWell(
                          borderRadius:
                              BorderRadius.circular(AppValues.generalRadius),
                          onTap: () async {
                            if (viewModel.audioFile?.path != null) {
                              await Share.shareXFiles(
                                [
                                  XFile(viewModel.audioFile?.path ?? '',
                                      name: (person.name ?? '') +
                                          Random().nextInt(999).toString())
                                ],
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                              color: themeData.colorScheme.secondaryBgColorDark,
                              borderRadius: BorderRadius.circular(
                                  AppValues.generalRadius),
                            ),
                            child: const Column(
                              children: [
                                Icon(Icons.ios_share_rounded),
                                SizedBox(height: 10),
                                Text(
                                  "Share",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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

                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
