import 'package:dio/dio.dart';
import 'package:megahd/app/models/trends.dart';
import 'package:megahd/app/shared/constants.dart';

class TrendsRep {
  Future<Trends> getTrends(
      {String language = "pt-BR", String page = "1"}) async {
    try {
      Response response = await Dio()
          .get("https://api.themoviedb.org/3/movie/popular", queryParameters: {
        "api_key": apiKey,
        "language": language,
        "page": page,
      });
      return Trends.fromJson(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
