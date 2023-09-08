// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on HomeViewModelBase, Store {
  late final _$celebritiesAtom =
      Atom(name: 'HomeViewModelBase.celebrities', context: context);

  @override
  List<PersonModel>? get celebrities {
    _$celebritiesAtom.reportRead();
    return super.celebrities;
  }

  @override
  set celebrities(List<PersonModel>? value) {
    _$celebritiesAtom.reportWrite(value, super.celebrities, () {
      super.celebrities = value;
    });
  }

  late final _$flagsAtom =
      Atom(name: 'HomeViewModelBase.flags', context: context);

  @override
  List<LangsModel> get flags {
    _$flagsAtom.reportRead();
    return super.flags;
  }

  @override
  set flags(List<LangsModel> value) {
    _$flagsAtom.reportWrite(value, super.flags, () {
      super.flags = value;
    });
  }

  late final _$selectedIdAtom =
      Atom(name: 'HomeViewModelBase.selectedId', context: context);

  @override
  String get selectedId {
    _$selectedIdAtom.reportRead();
    return super.selectedId;
  }

  @override
  set selectedId(String value) {
    _$selectedIdAtom.reportWrite(value, super.selectedId, () {
      super.selectedId = value;
    });
  }

  late final _$selectedLangAtom =
      Atom(name: 'HomeViewModelBase.selectedLang', context: context);

  @override
  String get selectedLang {
    _$selectedLangAtom.reportRead();
    return super.selectedLang;
  }

  @override
  set selectedLang(String value) {
    _$selectedLangAtom.reportWrite(value, super.selectedLang, () {
      super.selectedLang = value;
    });
  }

  late final _$tabIndexAtom =
      Atom(name: 'HomeViewModelBase.tabIndex', context: context);

  @override
  int get tabIndex {
    _$tabIndexAtom.reportRead();
    return super.tabIndex;
  }

  @override
  set tabIndex(int value) {
    _$tabIndexAtom.reportWrite(value, super.tabIndex, () {
      super.tabIndex = value;
    });
  }

  late final _$appModdedAtom =
      Atom(name: 'HomeViewModelBase.appModded', context: context);

  @override
  bool? get appModded {
    _$appModdedAtom.reportRead();
    return super.appModded;
  }

  @override
  set appModded(bool? value) {
    _$appModdedAtom.reportWrite(value, super.appModded, () {
      super.appModded = value;
    });
  }

  late final _$volumeUpAtom =
      Atom(name: 'HomeViewModelBase.volumeUp', context: context);

  @override
  bool get volumeUp {
    _$volumeUpAtom.reportRead();
    return super.volumeUp;
  }

  @override
  set volumeUp(bool value) {
    _$volumeUpAtom.reportWrite(value, super.volumeUp, () {
      super.volumeUp = value;
    });
  }

  late final _$tipTextsAtom =
      Atom(name: 'HomeViewModelBase.tipTexts', context: context);

  @override
  List<String> get tipTexts {
    _$tipTextsAtom.reportRead();
    return super.tipTexts;
  }

  @override
  set tipTexts(List<String> value) {
    _$tipTextsAtom.reportWrite(value, super.tipTexts, () {
      super.tipTexts = value;
    });
  }

  @override
  String toString() {
    return '''
celebrities: ${celebrities},
flags: ${flags},
selectedId: ${selectedId},
selectedLang: ${selectedLang},
tabIndex: ${tabIndex},
appModded: ${appModded},
volumeUp: ${volumeUp},
tipTexts: ${tipTexts}
    ''';
  }
}
