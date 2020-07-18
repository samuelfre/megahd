import 'package:megahd/app/modules/main_movie/main_movie_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:megahd/app/modules/main_movie/main_movie_page.dart';
import 'package:megahd/app/shared/ads_controller.dart';

class MainMovieModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => MainMovieController()),
      ];

  @override
  List<Router> get routers => [
        Router('/:index', child: (_, args) {
          Modular.get<AdsController>().showInterstitial();
          //debugPrint('${args?.params['index']}  OIDSODISODIS');
          return MainMoviePage(
            variavel: args.params['index'],
          );
        }),
      ];

  static Inject get to => Inject<MainMovieModule>.of();
}
