import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:megahd/app/shared/ads_controller.dart';
import 'package:megahd/app/shared/constants.dart';
import 'package:megahd/app/shared/tamanhoTela.dart';
import 'package:megahd/app/widgets/main-movie-widget/ComentariosTab.dart';
import 'package:megahd/app/widgets/main-movie-widget/TabCredits.dart';
import 'package:megahd/app/widgets/main-movie-widget/TabInfo.dart';
import 'main_movie_controller.dart';

class MainMoviePage extends StatefulWidget {
  final String title;
  final String variavel;
  MainMoviePage({Key key, this.title = "MainMovie", this.variavel})
      : super(key: key);

  @override
  _MainMoviePageState createState() => _MainMoviePageState();
}

class _MainMoviePageState
    extends ModularState<MainMoviePage, MainMovieController>
    with SingleTickerProviderStateMixin {
  TabController tabController; //Declarando o controller das Tabs

  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'INFO',
    ),
    Tab(text: 'ELENCO'),
    Tab(text: 'COMENTÁRIOS'),
  ]; //Declarando as tabs

  @override
  void initState() {
    debugPrint(widget?.variavel);
    tabController = TabController(
        vsync: this,
        length: myTabs.length); //Inicializando o controller das Tabs
    controller
        .initMovie(index: int.parse(widget.variavel))
        .whenComplete(() => controller.getComentarios(id: controller.movie.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Modular.get<AdsController>().showBanner(),
        appBar: AppBar(
          //bottom: TabBar(controller: _tabController, tabs: myTabs),
          title: Observer(builder: (_) {
            return Text(controller?.movie?.title ?? "Carregando");
          }),
        ),
        body: Column(
          children: <Widget>[
            Observer(builder: (_) {
              return Container(
                height: TamanhoTela(0.3, context).converterHeight(),
                width: double.infinity,
                child: controller?.movie == null
                    ? Center(
                        child: Text(
                        'Carregando...',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ))
                    : Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(pathBackImageMovie +
                                        controller?.movie?.backdropPath),
                                    fit: BoxFit.fill)),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              color: Colors.white60,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: TamanhoTela(0.65, context)
                                        .converterWidth(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          controller?.movie?.title,
                                          style: TextStyle(
                                              fontSize: 26,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              shadows: [
                                                Shadow(color: Colors.black),
                                              ]),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(controller?.movie?.tagline,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    controller?.movie?.voteAverage?.toString(),
                                    style: TextStyle(
                                        fontSize: 26,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              );
            }),
            Container(
              height: 50,
              width: double.infinity,
              child: TabBar(controller: tabController, tabs: myTabs),
            ),
            Expanded(
              child: Container(
                child: Observer(builder: (_) {
                  return TabBarView(controller: tabController, children: [
                    controller?.movie != null
                        ? SingleChildScrollView(
                            child: TabInfo(
                              controller: controller,
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                    controller?.credits != null
                        ? TabCredits(
                            controller: controller,
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                    ComentariosTab()
                  ]);
                }),
              ),
            ),
          ],
        ));
  }
}
