import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/success/succes.dart';
import '../repositories/note_repository.dart';

class ChangeNote {
  final NoteRepository repository;
  ChangeNote({@required this.repository});

  Future<Either<Failure, Success>> call(int id, String note) async {
    return await repository.changeNote(note, id);
  }
}
