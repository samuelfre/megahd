import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:megahd/app/modules/main_movie/main_movie_controller.dart';
import 'package:megahd/app/shared/tamanhoTela.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ApiStatus { Loading, Empty, Completed }

class ComentariosTab extends StatelessWidget {
  final MainMovieController controller = Modular.get<MainMovieController>();
  final TextEditingController textEditingController1;
  final TextEditingController textEditingController2;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey;

  ComentariosTab(
      {this.textEditingController1,
      this.textEditingController2,
      this.scaffoldKey});

  enviarComentario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var object = ParseObject('Comentarios')
      ..set('Nick', '${textEditingController1.text}')
      ..set('Comentario', '${textEditingController2.text}')
      ..set('FilmeId', controller.movie.id)
      ..set('idDispositivo', prefs.get('id').toString());
    await object
        .save()
        .then((value) => controller.getComentarios(id: controller.movie.id));
  }

  upVote(int index) async {
    String objectId = controller.listaComentarios[index]['objectId'];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (controller.listaComentarios[index]['listVoted'] != null) {
      List lista = List.from(controller.listaComentarios[index]['listVoted']);
      if (!lista.contains(prefs.get('id'))) {
        int votes = controller.listaComentarios[index]['Pvote'] + 1;
        var object = ParseObject('Comentarios')
          ..objectId = objectId
          ..set('Pvote', votes)
          ..setAdd('listVoted', prefs.get('id'));
        await object.save().then(
            (value) => controller.getComentarios(id: controller.movie.id));
      } else {
        debugPrint('ja votou');
      }
    } else {
      int votes = controller.listaComentarios[index]['Pvote'] + 1;
      var object = ParseObject('Comentarios')
        ..objectId = objectId
        ..set('Pvote', votes)
        ..setAdd('listVoted', prefs.get('id'));
      await object
          .save()
          .then((value) => controller.getComentarios(id: controller.movie.id));
    }
  }

  downVote(int index) async {
    String objectId = controller.listaComentarios[index]['objectId'];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (controller.listaComentarios[index]['listVoted'] != null) {
      List lista = List.from(controller.listaComentarios[index]['listVoted']);
      if (!lista.contains(prefs.get('id'))) {
        int votes = controller.listaComentarios[index]['Nvote'] + 1;
        if (votes > 15) {
          debugPrint('entrou aqui rapaz ');
          var object = ParseObject('Comentarios')
            ..objectId = objectId
            ..set('Ativo', false);
          await object.save().then(
              (value) => controller.getComentarios(id: controller.movie.id));
        }
        var object = ParseObject('Comentarios')
          ..objectId = objectId
          ..set('Nvote', votes)
          ..setAdd('listVoted', prefs.get('id'));
        await object.save().then(
            (value) => controller.getComentarios(id: controller.movie.id));
      } else {
        debugPrint('ja votou');
      }
    } else {
      int votes = controller.listaComentarios[index]['Nvote'] + 1;
      var object = ParseObject('Comentarios')
        ..objectId = objectId
        ..set('Nvote', votes)
        ..setAdd('listVoted', prefs.get('id'));
      await object
          .save()
          .then((value) => controller.getComentarios(id: controller.movie.id));
    }
  }

  Widget pegarData(int index) {
    DateTime s = controller
            .listaComentarios[(controller.listaComentarios.length - 1) - index]
        ['createdAt'];
    var formatter = new DateFormat('dd-MM-yyyy');
    String formatted = formatter.format(s);
    return Text(
      formatted,
      style: TextStyle(fontSize: 12),
    );
  }

  Widget retornarLista(BuildContext context) => Stack(
        children: <Widget>[
          ListView.builder(
            primary: true,
            shrinkWrap: true,
            itemCount: controller.listaComentarios.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      controller.listaComentarios[
                              (controller.listaComentarios.length - 1) - index]
                          ['Nick'],
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Column(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              controller.listaComentarios[
                                  (controller.listaComentarios.length - 1) -
                                      index]['Comentario'],
                              style: TextStyle(fontSize: 18),
                            )),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: pegarData(index)),
                                SizedBox(
                                  //PRO FUTUROOOO RSRS
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    SizedBox(
                                      width: TamanhoTela(0.08, context)
                                          .converterWidth(),
                                    ),
                                    //---------------------------------------------------------------
                                    IconButton(
                                        icon: Icon(Icons.thumb_up),
                                        onPressed: () => upVote((controller
                                                    .listaComentarios.length -
                                                1) -
                                            index)),
                                    Text(controller.listaComentarios[(controller
                                                    .listaComentarios.length -
                                                1) -
                                            index]['Pvote']
                                        .toString()),
                                    Container(
                                      width: 10,
                                      height: 30,
                                      child: VerticalDivider(
                                        thickness: 1.5,
                                      ),
                                    ),
                                    IconButton(
                                        enableFeedback: true,
                                        icon: Icon(Icons.thumb_down),
                                        onPressed: () => downVote((controller
                                                    .listaComentarios.length -
                                                1) -
                                            index)),
                                    Text(controller.listaComentarios[(controller
                                                    .listaComentarios.length -
                                                1) -
                                            index]['Nvote']
                                        .toString()),
                                    //---------------------------------------------------------------
                                    SizedBox(
                                      width: TamanhoTela(0.08, context)
                                          .converterWidth(),
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                  index != controller.listaComentarios.length - 1
                      ? Divider(
                          thickness: 1.5,
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  TamanhoTela(0.1, context).converterHeight()),
                          child: Divider(thickness: 5),
                        )
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              child: IconButton(
                  color: Theme.of(context).accentColor,
                  iconSize: 35,
                  icon: Icon(Icons.comment),
                  onPressed: () {
                    _showMyDialog(context);
                  }),
              alignment: Alignment.bottomRight,
            ),
          )
        ],
      );

  Widget inserirComentario(BuildContext context) => Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: textEditingController1,
                  maxLength: 15,
                  maxLines: 1,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor, insira algum texto';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Insira o seu nome',
                  ),
                ),
                TextFormField(
                  controller: textEditingController2,
                  maxLines: 6,
                  maxLength: 280,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor, insira algum texto';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Insira o seu comentário',
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Inserir comentário'),
          content: SingleChildScrollView(
            child: inserirComentario(context),
          ),
          actions: <Widget>[
            Align(
              alignment: Alignment.bottomRight,
              child: RaisedButton(
                  color: Colors.grey,
                  child: Text('Comentar'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      enviarComentario();
                      scaffoldKey.currentState.showSnackBar(
                          SnackBar(content: Text('Enviando Comentário...')));
                      Navigator.of(context).pop();
                    }
                  }),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        switch (controller.apiStatus) {
          case ApiStatus.Completed:
            return retornarLista(context);
            break;
          case ApiStatus.Empty:
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: TamanhoTela(0.18, context).converterHeight(),
                        bottom: TamanhoTela(0.12, context).converterHeight()),
                    child: Center(
                        child:
                            Text('Sem comentários ainda, seja o primeiro!!!')),
                  ),
                  Align(
                    child: IconButton(
                        color: Theme.of(context).accentColor,
                        iconSize: 35,
                        icon: Icon(Icons.comment),
                        onPressed: () {
                          _showMyDialog(context);
                        }),
                    alignment: Alignment.bottomRight,
                  )
                ],
              ),
            );
            break;
          default:
            return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
