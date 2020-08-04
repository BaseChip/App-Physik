import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'topic_entitie.dart';

class Topics extends Equatable{
  final List<Topic> topics;

  Topics({
    @required this.topics
  });

  @override
  List<Object> get props => [topics];
}