import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:megahd/app/shared/tamanhoTela.dart';
import 'package:megahd/app/widgets/feed-widget/MovieImageContainer.dart';
import 'package:megahd/app/widgets/feed-widget/MovieTitleContainer.dart';

class CustomCard extends StatelessWidget {
  final int index;
  CustomCard({this.index});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Modular.link.pushNamed('mainMovie/${index.toString()}'), //O CABAÇO
      child: Card(
        elevation: 5,
        child: Container(
          height: TamanhoTela(0.4, context).converterHeight(),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              MovieImageContainer(index: index),
              MovieTitleContainer(index: index),
            ],
          ),
        ),
      ),
    );
  }
}
