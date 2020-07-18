import 'package:megahd/app/modules/feed/feed_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:megahd/app/modules/feed/feed_page.dart';
import 'package:megahd/app/modules/main_movie/main_movie_module.dart';
import 'package:megahd/app/shared/ads_controller.dart';

class FeedModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => FeedController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) {
          Modular.get<AdsController>().showInterstitial();
          Modular.get<AdsController>().initBannerAdmob();
          return FeedPage();
        }),
        Router('mainMovie', module: MainMovieModule()),
      ];

  static Inject get to => Inject<FeedModule>.of();
}
