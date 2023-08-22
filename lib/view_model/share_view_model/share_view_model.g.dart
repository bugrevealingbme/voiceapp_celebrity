// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ShareViewModel on ShareViewModelBase, Store {
  late final _$eventDataAtom =
      Atom(name: 'ShareViewModelBase.eventData', context: context);

  @override
  EventData? get eventData {
    _$eventDataAtom.reportRead();
    return super.eventData;
  }

  @override
  set eventData(EventData? value) {
    _$eventDataAtom.reportWrite(value, super.eventData, () {
      super.eventData = value;
    });
  }

  late final _$audioFileAtom =
      Atom(name: 'ShareViewModelBase.audioFile', context: context);

  @override
  File? get audioFile {
    _$audioFileAtom.reportRead();
    return super.audioFile;
  }

  @override
  set audioFile(File? value) {
    _$audioFileAtom.reportWrite(value, super.audioFile, () {
      super.audioFile = value;
    });
  }

  late final _$waveformDataAtom =
      Atom(name: 'ShareViewModelBase.waveformData', context: context);

  @override
  List<double> get waveformData {
    _$waveformDataAtom.reportRead();
    return super.waveformData;
  }

  @override
  set waveformData(List<double> value) {
    _$waveformDataAtom.reportWrite(value, super.waveformData, () {
      super.waveformData = value;
    });
  }

  late final _$isPlayingAtom =
      Atom(name: 'ShareViewModelBase.isPlaying', context: context);

  @override
  bool? get isPlaying {
    _$isPlayingAtom.reportRead();
    return super.isPlaying;
  }

  @override
  set isPlaying(bool? value) {
    _$isPlayingAtom.reportWrite(value, super.isPlaying, () {
      super.isPlaying = value;
    });
  }

  @override
  String toString() {
    return '''
eventData: ${eventData},
audioFile: ${audioFile},
waveformData: ${waveformData},
isPlaying: ${isPlaying}
    ''';
  }
}
