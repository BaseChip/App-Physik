import 'package:flutter/cupertino.dart';

import '../../domain/entities/note_entitie.dart';

class NoteModel extends Note {
  NoteModel({@required String note, @required String title, @required int id})
      : super(note: note, title: title, id: id);

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(note: json['note'], title: json['title'], id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "note": note};
  }
}
