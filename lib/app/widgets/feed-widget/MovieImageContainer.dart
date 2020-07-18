import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:megahd/app/modules/feed/feed_controller.dart';
import 'package:megahd/app/shared/constants.dart';

class MovieImageContainer extends StatelessWidget {
  final FeedController controller = Modular.get<FeedController>();
  final int index;
  MovieImageContainer({this.index});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        child: Image(
          image: NetworkImage(pathBackImageMovie +
              controller.trends.results[index].backdropPath),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
