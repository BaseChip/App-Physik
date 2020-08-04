import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/success/succes.dart';
import '../repositories/note_repository.dart';

class DeleteNote {
  final NoteRepository repository;
  DeleteNote({@required this.repository});

  @override
  Future<Either<Failure, Success>> call(int id) async {
    return await repository.deleteNote(id);
  }
}
