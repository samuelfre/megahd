import 'package:dio/dio.dart';
import 'package:megahd/app/models/movieVideo.dart';
import 'package:megahd/app/shared/constants.dart';

class MoviesVideo {
  Future<MovieModel> getMovieVideo(
      {String id, String language = "pt-BR"}) async {
    try {
      Response response = await Dio().get(pathMovie + id + '/videos',
          queryParameters: {"api_key": apiKey, "language": language});
      return MovieModel.fromJson(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
