import 'package:dio/dio.dart';
import 'package:megahd/app/models/movie.dart';
import 'package:megahd/app/shared/constants.dart';

class MovieRep {

  Future<Movie> getMovie({String id, String language = "pt-BR"}) async {
    try {
      Response response = await Dio().get(pathMovie + id,
          queryParameters: {"api_key": apiKey, "language": language});
      return Movie.fromJson(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }
  
}