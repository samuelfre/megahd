import 'package:dio/dio.dart';
import 'package:megahd/app/models/credits.dart';
import 'package:megahd/app/shared/constants.dart';

class CreditsRep {
  Future<Credits> getElenco(String id) async {
    try {
      Response response = await Dio().get(pathMovie + id + '/credits',
          queryParameters: {"api_key": apiKey});
      return Credits.fromJson(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }
}