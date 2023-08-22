import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:mobx/mobx.dart';

import '../../models/event_data.dart';

part 'share_view_model.g.dart';

class ShareViewModel = ShareViewModelBase with _$ShareViewModel;

abstract class ShareViewModelBase with Store {
  late BuildContext lcontext;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @observable
  EventData? eventData;

  @observable
  File? audioFile;

  @observable
  List<double> waveformData = [];

  PlayerController controller = PlayerController();

  @observable
  bool? isPlaying = false;

  setContext(BuildContext context) => lcontext = context;

  init() async {
    if (eventData?.url != null) {
      audioFile = await DefaultCacheManager().getSingleFile(eventData!.url!);

      controller.onPlayerStateChanged.listen((playerState) {
        isPlaying = playerState.isPlaying;
      });

      await controller.preparePlayer(
        path: audioFile?.path ?? '',
        shouldExtractWaveform: true,
      );

      waveformData = await controller.extractWaveformData(
        path: audioFile?.path ?? '',
        noOfSamples: 100,
      );

      controller.startPlayer(
        finishMode: FinishMode.pause,
      );
    }
  }

  dispose() {
    controller.dispose();
  }
}
