import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:megahd/app/shared/ads_controller.dart';
import 'package:megahd/app/widgets/feed-widget/CustomCard.dart';
import 'feed_controller.dart';

class FeedPage extends StatefulWidget {
  final String title;
  const FeedPage({Key key, this.title = "Feed"}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends ModularState<FeedPage, FeedController> {
  @override
  void initState() {
    controller.getTrends();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Modular.get<AdsController>().showBanner(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.filter_list,
            size: 50,
            color: Theme.of(context).accentColor,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          splashColor: Colors.black,
        ),
        // drawer: CustomDrawer(),
        appBar: AppBar(
          title: Text(
            widget.title,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: Observer(
          builder: (BuildContext context) {
            return controller.trends != null
                ? ListView.builder(
                    itemCount: controller.trends.results.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomCard(index: index);
                    },
                  )
                : Center(child: CircularProgressIndicator());
          },
        ));
  }
}

class ObjetoIndex {
  final int index;
  ObjetoIndex({this.index});
}
