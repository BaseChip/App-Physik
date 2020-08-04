import 'package:flutter/cupertino.dart';

import '../../domain/entities/notes_entitie.dart';
import '../../domain/entities/notes_list_entitie.dart';
import 'notes_model.dart';

class NotesListModel extends NotesList {
  NotesListModel({@required List<Notes> notes}) : super(notes: notes);

  factory NotesListModel.fromJson(List<dynamic> json) {
    List<Notes> list = [];
    json.forEach((value) {
      list.add(NotesModel.fromJson(value));
    });
    return NotesListModel(notes: list);
  }
}
