// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ads_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AdsController on _AdsControllerBase, Store {
  final _$adBannerToShowAtom = Atom(name: '_AdsControllerBase.adBannerToShow');

  @override
  int get adBannerToShow {
    _$adBannerToShowAtom.reportRead();
    return super.adBannerToShow;
  }

  @override
  set adBannerToShow(int value) {
    _$adBannerToShowAtom.reportWrite(value, super.adBannerToShow, () {
      super.adBannerToShow = value;
    });
  }

  final _$_AdsControllerBaseActionController =
      ActionController(name: '_AdsControllerBase');

  @override
  void updateAdBannerToShow(int nState) {
    final _$actionInfo = _$_AdsControllerBaseActionController.startAction(
        name: '_AdsControllerBase.updateAdBannerToShow');
    try {
      return super.updateAdBannerToShow(nState);
    } finally {
      _$_AdsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
adBannerToShow: ${adBannerToShow}
    ''';
  }
}
