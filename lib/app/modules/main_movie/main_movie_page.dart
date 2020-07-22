import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:megahd/app/shared/ads_controller.dart';
import 'package:megahd/app/shared/constants.dart';
import 'package:megahd/app/shared/tamanhoTela.dart';
import 'package:megahd/app/widgets/main-movie-widget/ComentariosTab.dart';
import 'package:megahd/app/widgets/main-movie-widget/TabCredits.dart';
import 'package:megahd/app/widgets/main-movie-widget/TabInfo.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//import 'package:megahd/app/repositories/movies-video.dart';
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
  TextEditingController textEditingController1;
  TextEditingController textEditingController2;
  YoutubePlayerController youtubePlayerController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'INFO',
    ),
    Tab(text: 'TRAILER'),
    Tab(text: 'COMENTÁRIOS'),
    Tab(text: 'ELENCO'),
  ]; //Declarando as tabs

  @override
  void initState() {
    textEditingController1 = TextEditingController();
    textEditingController2 = TextEditingController();
    tabController = TabController(
        vsync: this,
        length: myTabs.length); //Inicializando o controller das Tabs
    controller.initMovie(index: int.parse(widget.variavel)).whenComplete(() {
      debugPrint('KEYYY ' + controller.movieModel.results[0].key);
      youtubePlayerController = YoutubePlayerController(
          flags: YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
          ),
          initialVideoId: controller.movieModel.results[0].key);
      return controller.getComentarios(id: controller.movie.id);
    });
    super.initState();
  }

  @override
  void dispose() {
    textEditingController1.dispose();
    textEditingController2.dispose();
    tabController.dispose();
    youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: Modular.get<AdsController>().showBanner(),
        // bottomNavigationBar: AdsBottomFalse(),
        appBar: AppBar(
          //bottom: TabBar(controller: _tabController, tabs: myTabs),
          title: Observer(builder: (_) {
            return Text(controller?.movie?.title ?? "Carregando");
          }),
        ),
        body: SingleChildScrollView(
          child: Column(
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
                                      image: controller?.movie?.backdropPath !=
                                              null
                                          ? NetworkImage(pathBackImageMovie +
                                              controller?.movie?.backdropPath)
                                          : AssetImage('assets/img2.jpg'),
                                      fit: BoxFit.fill)),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                  Colors.white60,
                                  Colors.grey[400]
                                ])),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                                      controller?.movie?.voteAverage
                                          ?.toString(),
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
              Container(
                height: TamanhoTela(0.4, context).converterHeight(),
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
                    //Container(),
                    controller?.movieModel != null
                        ? YoutubePlayerBuilder(
                            player: YoutubePlayer(
                              controller: youtubePlayerController,
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.amber,
                              progressColors: ProgressBarColors(
                                playedColor: Colors.amber,
                                handleColor: Colors.amberAccent,
                              ),
                              onReady: () {
                                debugPrint('Player is ready.');
                                youtubePlayerController.addListener(() {});
                              },
                            ),
                            builder: (BuildContext context, Widget widget) {
                              return Column(
                                children: [
                                  // some widgets
                                  widget,
                                  Text('asdf')
                                  //some other widgets
                                ],
                              );
                            },
                          )
                        // Center(
                        //     child: Container(
                        //       color: Colors.red,
                        //       height: 50,
                        //       width: 150,
                        //       child: InkWell(
                        //         child: Text('data'),
                        // onTap: () => Modular.link.pushNamed(
                        //     'controller/',
                        //     arguments: youtubePlayerController),
                        //       ),
                        //     ),
                        //   )

                        : Center(child: CircularProgressIndicator()),
                    ComentariosTab(
                      scaffoldKey: _scaffoldKey,
                      textEditingController1: textEditingController1,
                      textEditingController2: textEditingController2,
                    ),
                    controller?.credits != null
                        ? TabCredits(
                            controller: controller,
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ]);
                }),
              ),
            ],
          ),
        ));
  }
}
