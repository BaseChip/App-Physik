import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'notes_entitie.dart';

class NotesList extends Equatable {
  final List<Notes> notes;

  NotesList({@required this.notes});
  @override
  List<Object> get props => [notes];
}
