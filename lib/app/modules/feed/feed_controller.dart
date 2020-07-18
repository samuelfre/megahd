import 'package:megahd/app/models/trends.dart';
import 'package:megahd/app/repositories/trends-rep.dart';
import 'package:mobx/mobx.dart';

part 'feed_controller.g.dart';

class FeedController = _FeedControllerBase with _$FeedController;

abstract class _FeedControllerBase with Store {
  
  TrendsRep trendsRep = TrendsRep();

  @observable
  Trends trends;

  @action
  Future<void> getTrends() async {
    trends = await trendsRep.getTrends();
  }
}
