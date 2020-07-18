import 'package:flutter/material.dart';
import 'package:megahd/app/modules/main_movie/main_movie_controller.dart';

class TabInfo extends StatelessWidget {
  final MainMovieController controller;
  TabInfo({this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Sinopse',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          Text(controller.movie.overview,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
          Text('Data de Lançamento',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          Text(controller.movie.releaseDate,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
          Text('Tempo de Filme',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          Text(controller.movie.runtime.toString() + ' minutos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
          Text('Gênero',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          Container(
            height: 70,
            child: ListView.builder(
              itemCount: controller.movie.genres.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(controller.movie.genres[index].name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300));
              },
            ),
          )
        ],
      ),
    );
  }
}
