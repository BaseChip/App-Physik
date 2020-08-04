import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/success/succes.dart';
import '../entities/note_entitie.dart';
import '../entities/notes_list_entitie.dart';

abstract class NoteRepository {
  Future<Either<Failure, Note>> getNote(int id);
  Future<Either<Failure, NotesList>> getAllNotes();
  Future<Either<Failure, Success>> deleteNote(int id);
  Future<Either<Failure, Success>> changeNote(String note, int id);
  Future<Either<Failure, Success>> addNote(String title, String note);
}
