import 'package:flutter/material.dart';
import 'package:megahd/app/modules/main_movie/main_movie_controller.dart';
import 'package:megahd/app/shared/constants.dart';

class TabCredits extends StatelessWidget {
  final MainMovieController controller;
  TabCredits({this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: GridView.builder(
          itemCount: controller.credits.cast.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, i) => Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: 150,
                width: 150,
                //color: Colors.red,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            image: controller.credits.cast[i].profilePath !=
                                    null
                                ? DecorationImage(
                                    image: NetworkImage(pathImageFeed +
                                        controller.credits.cast[i].profilePath),
                                    fit: BoxFit.fill)
                                : DecorationImage(
                                    image: AssetImage('assets/img1.png'),
                                    fit: BoxFit.fill,
                                  )),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              controller.credits.cast[i].name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  backgroundColor: Colors.white60,
                                  color: Colors.black),
                            )),
                      ),
                    ),
                    Text(
                      controller.credits.cast[i].character,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )),
    );
  }
}
