import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Topic extends Equatable{
  final int id;
  final String topic;


  Topic({
    @required this.id,
    @required this.topic,
    });

  @override
  List<Object> get props => [id, topic];
}