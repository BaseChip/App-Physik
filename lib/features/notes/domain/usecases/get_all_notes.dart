import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failure.dart';
import '../entities/notes_list_entitie.dart';
import '../repositories/note_repository.dart';

class GetAllNotes {
  final NoteRepository repository;
  GetAllNotes({@required this.repository});

  Future<Either<Failure, NotesList>> call() async {
    return await repository.getAllNotes();
  }
}
