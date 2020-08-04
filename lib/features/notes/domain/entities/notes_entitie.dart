import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Notes extends Equatable {
  final String title;
  final int id;

  Notes({@required this.title, @required this.id});
  @override
  List<Object> get props => [title, id];
}
