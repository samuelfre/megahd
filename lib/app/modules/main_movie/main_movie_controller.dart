import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:megahd/app/models/credits.dart';
import 'package:megahd/app/models/movie.dart';
import 'package:megahd/app/models/movieVideo.dart';
import 'package:megahd/app/modules/feed/feed_controller.dart';
import 'package:megahd/app/repositories/credits-rep.dart';
import 'package:megahd/app/repositories/movies-rep.dart';
import 'package:megahd/app/repositories/movies-video.dart';
import 'package:megahd/app/widgets/main-movie-widget/ComentariosTab.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

part 'main_movie_controller.g.dart';

class MainMovieController = _MainMovieControllerBase with _$MainMovieController;
enum Trailer { comTrailer, semTrailer }

abstract class _MainMovieControllerBase with Store {
  @observable
  Movie movie; //Model
  @observable
  Credits credits; //Model
  @observable
  MovieModel movieModel; //Model

  @observable
  bool ficarNulo = false;

  @observable
  ObservableList<dynamic> _listaComentarios = ObservableList<dynamic>.of([]);

  @observable
  YoutubePlayerController youtubePlayerController;
  @observable
  PlayerState playerState;
  @observable
  YoutubeMetaData videoMetaData;
  @observable
  Trailer trailer;

  @observable
  String s = 'Valor inicial...';

  @observable
  ApiStatus apiStatus;

  MovieRep movieRep = MovieRep(); //Repositório
  CreditsRep creditsRep = CreditsRep(); //Repositório
  MoviesVideo moviesVideo = MoviesVideo(); //Repositório
  FeedController feedController = Modular.get<FeedController>();

  @computed
  List<dynamic> get listaComentarios => _listaComentarios.asObservable();

  @action
  Future<void> initMovie({int index, String language = "pt-BR"}) async {
    //Iniciando o Model com o método do repositório
    movie = await movieRep.getMovie(
        id: feedController.trends.results[index].id.toString(),
        language: language);
    credits = await creditsRep
        .getElenco(feedController.trends.results[index].id.toString());
    movieModel = await moviesVideo.getMovieVideo(
        id: movie.id.toString(), language: language);
  }

  @action
  Future<void> getComentarios({int id}) async {
    apiStatus = ApiStatus.Loading;
    _listaComentarios.clear();

    var queryBuilder = QueryBuilder<ParseObject>(ParseObject('Comentarios'))
      ..whereEqualTo('FilmeId', id);

    ParseResponse response = await queryBuilder.query();

    if (response.success) {
      if (response.results.isEmpty) {
        s = 'Entrou no response.results.isEmpty';
        debugPrint('entrou aquie no isEmpty');
        apiStatus = ApiStatus.Empty;
      } else {
        List listResultos = List();
        for (var item in response.results) {
          if (item['Ativo'] == true) {
            listResultos.add(item);
          }
        }
        _listaComentarios.addAll(listResultos);
        if (_listaComentarios.isNotEmpty)
          apiStatus = ApiStatus.Completed;
        else if (_listaComentarios.isEmpty) {
          s = 'Entrou no _listaComentarios.isEmpty';
          apiStatus = ApiStatus.Empty;
        }
      }
    } else {
      s = 'Entrou no ultimo else';
      debugPrint('entrou aquie no else');
      apiStatus = ApiStatus.Empty;
    }
  }
}
