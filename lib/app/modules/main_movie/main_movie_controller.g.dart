// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_movie_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainMovieController on _MainMovieControllerBase, Store {
  final _$movieAtom = Atom(name: '_MainMovieControllerBase.movie');

  @override
  Movie get movie {
    _$movieAtom.reportRead();
    return super.movie;
  }

  @override
  set movie(Movie value) {
    _$movieAtom.reportWrite(value, super.movie, () {
      super.movie = value;
    });
  }

  final _$creditsAtom = Atom(name: '_MainMovieControllerBase.credits');

  @override
  Credits get credits {
    _$creditsAtom.reportRead();
    return super.credits;
  }

  @override
  set credits(Credits value) {
    _$creditsAtom.reportWrite(value, super.credits, () {
      super.credits = value;
    });
  }

  final _$responseAtom = Atom(name: '_MainMovieControllerBase.response');

  @override
  ParseResponse get response {
    _$responseAtom.reportRead();
    return super.response;
  }

  @override
  set response(ParseResponse value) {
    _$responseAtom.reportWrite(value, super.response, () {
      super.response = value;
    });
  }

  final _$apiStatusAtom = Atom(name: '_MainMovieControllerBase.apiStatus');

  @override
  ApiStatus get apiStatus {
    _$apiStatusAtom.reportRead();
    return super.apiStatus;
  }

  @override
  set apiStatus(ApiStatus value) {
    _$apiStatusAtom.reportWrite(value, super.apiStatus, () {
      super.apiStatus = value;
    });
  }

  final _$initMovieAsyncAction =
      AsyncAction('_MainMovieControllerBase.initMovie');

  @override
  Future<void> initMovie({int index, String language = "pt-BR"}) {
    return _$initMovieAsyncAction
        .run(() => super.initMovie(index: index, language: language));
  }

  final _$getComentariosAsyncAction =
      AsyncAction('_MainMovieControllerBase.getComentarios');

  @override
  Future<void> getComentarios({int id}) {
    return _$getComentariosAsyncAction.run(() => super.getComentarios(id: id));
  }

  @override
  String toString() {
    return '''
movie: ${movie},
credits: ${credits},
response: ${response},
apiStatus: ${apiStatus}
    ''';
  }
}
