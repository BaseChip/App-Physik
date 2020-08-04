import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failure.dart';
import '../entities/note_entitie.dart';
import '../repositories/note_repository.dart';

class GetNote {
  final NoteRepository repository;
  GetNote({@required this.repository});

  @override
  Future<Either<Failure, Note>> call(int id) async {
    return await repository.getNote(id);
  }
}
