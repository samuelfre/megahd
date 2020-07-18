import 'package:megahd/app/modules/home/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:megahd/app/modules/home/home_page.dart';
import 'package:megahd/app/shared/ads_controller.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) {
          Modular.get<AdsController>().showInterstitial();
          return HomePage();
        }),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
