import 'package:meta/meta.dart';

import '../../domain/entities/topic_entitie.dart';


class TopicModel extends Topic{
  TopicModel({
    @required int id,
    @required String topic
  }) : super(id: id, topic: topic);

  factory TopicModel.fromJson(Map<String, dynamic> json){
    return TopicModel(id: json['id'], topic: json['topic']);
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "topic": topic
    };
  }
}