// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FeedController on _FeedControllerBase, Store {
  final _$trendsAtom = Atom(name: '_FeedControllerBase.trends');

  @override
  Trends get trends {
    _$trendsAtom.reportRead();
    return super.trends;
  }

  @override
  set trends(Trends value) {
    _$trendsAtom.reportWrite(value, super.trends, () {
      super.trends = value;
    });
  }

  final _$getTrendsAsyncAction = AsyncAction('_FeedControllerBase.getTrends');

  @override
  Future<void> getTrends() {
    return _$getTrendsAsyncAction.run(() => super.getTrends());
  }

  @override
  String toString() {
    return '''
trends: ${trends}
    ''';
  }
}
