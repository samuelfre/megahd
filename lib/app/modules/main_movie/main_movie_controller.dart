import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:megahd/app/models/credits.dart';
import 'package:megahd/app/models/movie.dart';
import 'package:megahd/app/modules/feed/feed_controller.dart';
import 'package:megahd/app/repositories/credits-rep.dart';
import 'package:megahd/app/repositories/movies-rep.dart';
import 'package:megahd/app/widgets/main-movie-widget/ComentariosTab.dart';
import 'package:mobx/mobx.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

part 'main_movie_controller.g.dart';

class MainMovieController = _MainMovieControllerBase with _$MainMovieController;

abstract class _MainMovieControllerBase with Store {
  @observable
  Movie movie; //Model
  @observable
  Credits credits; //Model
  @observable
  ParseResponse response = ParseResponse();
  @observable
  ApiStatus apiStatus = ApiStatus.Loading;

  MovieRep movieRep = MovieRep(); //Repositório
  CreditsRep creditsRep = CreditsRep(); //Repositório
  FeedController feedController = Modular.get<FeedController>();

  @action
  Future<void> initMovie({int index, String language = "pt-BR"}) async {
    //Iniciando o Model com o método do repositório
    debugPrint(index.toString());
    debugPrint(feedController.trends.results[index].id.toString());
    movie = await movieRep.getMovie(
        id: feedController.trends.results[index].id.toString(),
        language: language);
    credits = await creditsRep
        .getElenco(feedController.trends.results[index].id.toString());
  }

  @action
  Future<void> getComentarios({int id}) async {
    apiStatus = ApiStatus.Loading;

    var queryBuilder = QueryBuilder<ParseObject>(ParseObject('Comentarios'))
      ..whereEqualTo('FilmeId', id);
    response = await queryBuilder.query();

    if (response.success) {
      if (response?.results?.isEmpty) {
        apiStatus = ApiStatus.Empty;
      } else
        apiStatus = ApiStatus.Completed;
    } else
      apiStatus = ApiStatus.Empty;
  }
}
