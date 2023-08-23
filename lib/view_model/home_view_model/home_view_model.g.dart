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

  @override
  String toString() {
    return '''
celebrities: ${celebrities},
selectedId: ${selectedId},
tabIndex: ${tabIndex}
    ''';
  }
}
