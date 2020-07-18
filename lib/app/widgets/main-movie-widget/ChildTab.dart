import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:megahd/app/modules/main_movie/main_movie_controller.dart';

class ChildTab extends StatelessWidget {
  final MainMovieController controller = Modular.get<MainMovieController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      width: 25,
      height: 25,
    );
  }
}
