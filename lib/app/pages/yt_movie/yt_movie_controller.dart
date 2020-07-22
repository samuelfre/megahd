import 'package:mobx/mobx.dart';

part 'yt_movie_controller.g.dart';

class YtMovieController = _YtMovieControllerBase with _$YtMovieController;

abstract class _YtMovieControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
