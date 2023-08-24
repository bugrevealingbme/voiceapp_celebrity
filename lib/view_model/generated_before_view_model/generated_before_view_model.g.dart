// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generated_before_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GeneratedBeforeViewModel on GeneratedBeforeViewModelBase, Store {
  late final _$generatedBeforeAtom = Atom(
      name: 'GeneratedBeforeViewModelBase.generatedBefore', context: context);

  @override
  List<GeneratedModel>? get generatedBefore {
    _$generatedBeforeAtom.reportRead();
    return super.generatedBefore;
  }

  @override
  set generatedBefore(List<GeneratedModel>? value) {
    _$generatedBeforeAtom.reportWrite(value, super.generatedBefore, () {
      super.generatedBefore = value;
    });
  }

  late final _$tabIndexAtom =
      Atom(name: 'GeneratedBeforeViewModelBase.tabIndex', context: context);

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
generatedBefore: ${generatedBefore},
tabIndex: ${tabIndex}
    ''';
  }
}
