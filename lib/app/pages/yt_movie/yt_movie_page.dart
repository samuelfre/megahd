import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'yt_movie_controller.dart';

class YtMoviePage extends StatefulWidget {
  final String title;
  final YoutubePlayerController youtubePlayerController;
  const YtMoviePage(
      {Key key, this.title = "YtMovie", this.youtubePlayerController})
      : super(key: key);

  @override
  _YtMoviePageState createState() => _YtMoviePageState();
}

class _YtMoviePageState extends ModularState<YtMoviePage, YtMovieController> {
  //use 'controller' variable to access controller

  @override
  void dispose() {
    widget.youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(
          onEnded: (metaData) => Modular.link.pop(),
          controller: widget.youtubePlayerController,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
          onReady: () {
            debugPrint('Player is ready.');
            widget.youtubePlayerController.addListener(() {});
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
      ),
    );
  }
}
