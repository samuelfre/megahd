import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:megahd/app/modules/main_movie/main_movie_controller.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

enum ApiStatus { Loading, Empty, Completed }

class ComentariosTab extends StatelessWidget {
  final MainMovieController controller = Modular.get<MainMovieController>();

  Widget get retornarLista => ListView.builder(
        itemCount: controller.response.results.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              ListTile(
                title: Text(controller.response.results[index]['Nick']),
                subtitle:
                    Text(controller.response.results[index]['Comentario']),
                // onTap: () {
                //   debugPrint('Aquieee ' +
                //       controller.response.results[index]['Comentario']
                //           .toString() +
                //       ' Auieee');
                //   controller.getComentarios(id: controller.movie.id);
                // },
              ),
              Divider(
                thickness: 1.5,
              )
            ],
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        switch (controller.apiStatus) {
          case ApiStatus.Completed:
            return retornarLista;
            break;
          case ApiStatus.Empty:
            return Center(
              child: Text('Sem Comentários'),
            );
            break;
          default:
            return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
