import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/success/succes.dart';
import '../repositories/note_repository.dart';

class AddNote {
  final NoteRepository repository;
  AddNote({@required this.repository});

  @override
  Future<Either<Failure, Success>> call(String title, String note) async {
    return await repository.addNote(title, note);
  }
}
