import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Note extends Equatable {
  final String note;
  final String title;
  final int id;

  Note({@required this.note, @required this.title, @required this.id});
  @override
  List<Object> get props => [note, title, id];
}
