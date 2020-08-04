import 'package:flutter/cupertino.dart';

import '../../domain/entities/notes_entitie.dart';

class NotesModel extends Notes {
  NotesModel({@required String note, @required int id})
      : super(title: note, id: id);

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(note: json['title'], id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "note": title};
  }
}
