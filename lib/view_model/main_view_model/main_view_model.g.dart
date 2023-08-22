// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MainViewModel on MainViewModelBase, Store {
  late final _$viewListAtom =
      Atom(name: 'MainViewModelBase.viewList', context: context);

  @override
  List<Widget> get viewList {
    _$viewListAtom.reportRead();
    return super.viewList;
  }

  @override
  set viewList(List<Widget> value) {
    _$viewListAtom.reportWrite(value, super.viewList, () {
      super.viewList = value;
    });
  }

  late final _$currentIndexAtom =
      Atom(name: 'MainViewModelBase.currentIndex', context: context);

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  late final _$isPageTopAtom =
      Atom(name: 'MainViewModelBase.isPageTop', context: context);

  @override
  bool get isPageTop {
    _$isPageTopAtom.reportRead();
    return super.isPageTop;
  }

  @override
  set isPageTop(bool value) {
    _$isPageTopAtom.reportWrite(value, super.isPageTop, () {
      super.isPageTop = value;
    });
  }

  late final _$currentIndexNotifyAtom =
      Atom(name: 'MainViewModelBase.currentIndexNotify', context: context);

  @override
  ValueNotifier<int> get currentIndexNotify {
    _$currentIndexNotifyAtom.reportRead();
    return super.currentIndexNotify;
  }

  @override
  set currentIndexNotify(ValueNotifier<int> value) {
    _$currentIndexNotifyAtom.reportWrite(value, super.currentIndexNotify, () {
      super.currentIndexNotify = value;
    });
  }

  late final _$isPageTopNotifyAtom =
      Atom(name: 'MainViewModelBase.isPageTopNotify', context: context);

  @override
  ValueNotifier<bool> get isPageTopNotify {
    _$isPageTopNotifyAtom.reportRead();
    return super.isPageTopNotify;
  }

  @override
  set isPageTopNotify(ValueNotifier<bool> value) {
    _$isPageTopNotifyAtom.reportWrite(value, super.isPageTopNotify, () {
      super.isPageTopNotify = value;
    });
  }

  late final _$MainViewModelBaseActionController =
      ActionController(name: 'MainViewModelBase', context: context);

  @override
  dynamic updateCurrentIndex(int index) {
    final _$actionInfo = _$MainViewModelBaseActionController.startAction(
        name: 'MainViewModelBase.updateCurrentIndex');
    try {
      return super.updateCurrentIndex(index);
    } finally {
      _$MainViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
viewList: ${viewList},
currentIndex: ${currentIndex},
isPageTop: ${isPageTop},
currentIndexNotify: ${currentIndexNotify},
isPageTopNotify: ${isPageTopNotify}
    ''';
  }
}
