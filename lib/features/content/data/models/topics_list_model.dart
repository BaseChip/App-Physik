import 'package:flutter/cupertino.dart';

import '../../domain/entities/topic_entitie.dart';
import '../../domain/entities/topics_entitie.dart';
import 'topic_model.dart';

class TopicsListModel extends Topics{
  TopicsListModel({
    @required List<Topic> topics
  }) : super(topics: topics);

  factory TopicsListModel.fromJson(List<dynamic> json){
    List<Topic> list = [];
    json.forEach(
      (value){
        list.add(TopicModel.fromJson(value));
        });
    return TopicsListModel(topics: list);
  }
}