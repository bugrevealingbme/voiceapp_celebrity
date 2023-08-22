// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upgrade_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UpgradeViewModel on UpgradeViewModelBase, Store {
  late final _$offeringsAtom =
      Atom(name: 'UpgradeViewModelBase.offerings', context: context);

  @override
  Offerings? get offerings {
    _$offeringsAtom.reportRead();
    return super.offerings;
  }

  @override
  set offerings(Offerings? value) {
    _$offeringsAtom.reportWrite(value, super.offerings, () {
      super.offerings = value;
    });
  }

  late final _$selectedPAtom =
      Atom(name: 'UpgradeViewModelBase.selectedP', context: context);

  @override
  String get selectedP {
    _$selectedPAtom.reportRead();
    return super.selectedP;
  }

  @override
  set selectedP(String value) {
    _$selectedPAtom.reportWrite(value, super.selectedP, () {
      super.selectedP = value;
    });
  }

  @override
  String toString() {
    return '''
offerings: ${offerings},
selectedP: ${selectedP}
    ''';
  }
}
