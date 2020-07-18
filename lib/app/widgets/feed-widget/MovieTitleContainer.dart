import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:megahd/app/modules/feed/feed_controller.dart';

class MovieTitleContainer extends StatelessWidget {
  final int index;
  final FeedController controller = Modular.get<FeedController>();
  MovieTitleContainer({this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    controller.trends.results[index].title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                //Expanded(child: SizedBox()),
                Container(
                  child: Row(
                    children: <Widget>[
                      Text(
                        controller.trends.results[index].voteAverage.toString(),
                        textAlign: TextAlign.end,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.star),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              child: Column(
                children: <Widget>[
                  Text(
                    controller.trends.results[index].overview,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
