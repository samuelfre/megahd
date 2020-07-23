// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_movie_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainMovieController on _MainMovieControllerBase, Store {
  Computed<List<dynamic>> _$listaComentariosComputed;

  @override
  List<dynamic> get listaComentarios => (_$listaComentariosComputed ??=
          Computed<List<dynamic>>(() => super.listaComentarios,
              name: '_MainMovieControllerBase.listaComentarios'))
      .value;

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

  final _$movieModelAtom = Atom(name: '_MainMovieControllerBase.movieModel');

  @override
  MovieModel get movieModel {
    _$movieModelAtom.reportRead();
    return super.movieModel;
  }

  @override
  set movieModel(MovieModel value) {
    _$movieModelAtom.reportWrite(value, super.movieModel, () {
      super.movieModel = value;
    });
  }

  final _$ficarNuloAtom = Atom(name: '_MainMovieControllerBase.ficarNulo');

  @override
  bool get ficarNulo {
    _$ficarNuloAtom.reportRead();
    return super.ficarNulo;
  }

  @override
  set ficarNulo(bool value) {
    _$ficarNuloAtom.reportWrite(value, super.ficarNulo, () {
      super.ficarNulo = value;
    });
  }

  final _$_listaComentariosAtom =
      Atom(name: '_MainMovieControllerBase._listaComentarios');

  @override
  ObservableList<dynamic> get _listaComentarios {
    _$_listaComentariosAtom.reportRead();
    return super._listaComentarios;
  }

  @override
  set _listaComentarios(ObservableList<dynamic> value) {
    _$_listaComentariosAtom.reportWrite(value, super._listaComentarios, () {
      super._listaComentarios = value;
    });
  }

  final _$youtubePlayerControllerAtom =
      Atom(name: '_MainMovieControllerBase.youtubePlayerController');

  @override
  YoutubePlayerController get youtubePlayerController {
    _$youtubePlayerControllerAtom.reportRead();
    return super.youtubePlayerController;
  }

  @override
  set youtubePlayerController(YoutubePlayerController value) {
    _$youtubePlayerControllerAtom
        .reportWrite(value, super.youtubePlayerController, () {
      super.youtubePlayerController = value;
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
movieModel: ${movieModel},
ficarNulo: ${ficarNulo},
youtubePlayerController: ${youtubePlayerController},
apiStatus: ${apiStatus},
listaComentarios: ${listaComentarios}
    ''';
  }
}
