import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:megahd/app/shared/adsBottomFalse.dart';
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
  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  Size screenSizeH;
  Size screenSizeW;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'INFO',
    ),
    Tab(text: 'TRAILER'),
    Tab(text: 'COMENTÁRIOS'),
    Tab(text: 'ELENCO'),
  ]; //Declarando as tabs

  void listener() {
    if (_isPlayerReady &&
        mounted &&
        !controller.youtubePlayerController.value.isFullScreen) {
      setState(() {
        _playerState = controller.youtubePlayerController.value.playerState;
        _videoMetaData = controller.youtubePlayerController.metadata;
      });
    }
  }

  Widget get tabInfo => controller?.movie != null
      ? SingleChildScrollView(
          child: TabInfo(
            controller: controller,
          ),
        )
      : Center(
          child: CircularProgressIndicator(),
        );

  Widget get tabComentarios => ComentariosTab(
        scaffoldKey: _scaffoldKey,
        textEditingController1: textEditingController1,
        textEditingController2: textEditingController2,
      );

  Widget get tabCredits => controller?.credits != null
      ? TabCredits(
          controller: controller,
        )
      : Center(
          child: CircularProgressIndicator(),
        );
  Widget get getPlayer => YoutubePlayer(
        aspectRatio: 4 / 3,
        controller: controller.youtubePlayerController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              controller.youtubePlayerController.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          // IconButton(
          //   icon: const Icon(
          //     Icons.settings,
          //     color: Colors.white,
          //     size: 25.0,
          //   ),
          //   onPressed: () {
          //     debugPrint('Settings Tapped!');
          //   },
          // ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        // onEnded: (data) {
        //   controller.youtubePlayerController
        //       .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
        //   _showSnackBar('Next Video Started!');
        // }
      );

  @override
  void deactivate() {
    controller.youtubePlayerController.pause();
    super.deactivate();
  }

  @override
  void initState() {
    textEditingController1 = TextEditingController();
    textEditingController2 = TextEditingController();
    tabController = TabController(
        vsync: this,
        length: myTabs.length); //Inicializando o controller das Tabs
    controller.initMovie(index: int.parse(widget.variavel)).whenComplete(() {
      controller.youtubePlayerController = YoutubePlayerController(
          flags: const YoutubePlayerFlags(
            mute: false,
            autoPlay: false,
            disableDragSeek: false,
            loop: false,
            isLive: false,
            forceHD: false,
            enableCaption: true,
          ),
          initialVideoId: controller.movieModel.results[0].key);
      return controller.getComentarios(id: controller.movie.id);
    });
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;

    super.initState();
  }

  @override
  void dispose() {
    textEditingController1.dispose();
    textEditingController2.dispose();
    tabController.dispose();
    controller.youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        return controller.youtubePlayerController != null
            ? YoutubePlayerBuilder(
                onExitFullScreen: () => SystemChrome.setPreferredOrientations(
                    DeviceOrientation.values),
                player: getPlayer,
                builder: (BuildContext context, Widget widget) {
                  return Scaffold(
                    key: _scaffoldKey,
                    // bottomNavigationBar:
                    //     Modular.get<AdsController>().showBanner(),
                    bottomNavigationBar: AdsBottomFalse(),
                    appBar: AppBar(
                      //bottom: TabBar(controller: _tabController, tabs: myTabs),
                      title: Observer(builder: (_) {
                        return Text(controller?.movie?.title ?? "Carregando");
                      }),
                    ),
                    // resizeToAvoidBottomPadding: false,
                    // resizeToAvoidBottomInset: true,
                    body: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Observer(builder: (_) {
                            return Container(
                              height:
                                  TamanhoTela(0.3, context).converterHeight(),
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
                                                  image: controller?.movie
                                                              ?.backdropPath !=
                                                          null
                                                      ? NetworkImage(
                                                          pathBackImageMovie +
                                                              controller?.movie
                                                                  ?.backdropPath)
                                                      : AssetImage(
                                                          'assets/img2.jpg'),
                                                  fit: BoxFit.fill)),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [
                                                  Colors.white60,
                                                  Colors.grey[400]
                                                ])),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  width:
                                                      TamanhoTela(0.65, context)
                                                          .converterWidth(),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Text(
                                                        controller
                                                            ?.movie?.title,
                                                        style: TextStyle(
                                                            fontSize: 26,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            shadows: [
                                                              Shadow(
                                                                  color: Colors
                                                                      .black),
                                                            ]),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Text(
                                                          controller
                                                              ?.movie?.tagline,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  controller?.movie?.voteAverage
                                                      ?.toString(),
                                                  style: TextStyle(
                                                      fontSize: 26,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                            child:
                                TabBar(controller: tabController, tabs: myTabs),
                          ),
                          Observer(
                            builder: (BuildContext context) {
                              return controller?.movieModel != null
                                  ? Container(
                                      height: TamanhoTela(0.4, context)
                                          .converterHeight(),
                                      child: TabBarView(
                                          controller: tabController,
                                          children: [
                                            tabInfo,
                                            getPlayer,
                                            tabComentarios,
                                            tabCredits
                                          ]),
                                    )
                                  : Center(child: CircularProgressIndicator());
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
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}
