import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/success/succes.dart';
import '../../domain/entities/note_entitie.dart';
import '../../domain/entities/notes_list_entitie.dart';
import '../../domain/usecases/add_note.dart';
import '../../domain/usecases/change_note.dart';
import '../../domain/usecases/delete_note.dart';
import '../../domain/usecases/get_all_notes.dart';
import '../../domain/usecases/get_note.dart';

part 'notes_event.dart';
part 'notes_state.dart';

const String SERVER_FAILURE_MESSAGE = "Server Fehler";
const String OFFLINE_FAILURE_MESSAGE =
    "Es scheint als wärst du offline, doch für diese Funktion wird eine Internetverbindung benötigt :(";
const String ARGS_MISSING_FAILURE_MESSAGE =
    "Internal Error - irgendwas stimmt nicht mit den Daten die wir an die Api übergeben haben, sollte dieser Fall öffter auftreten, melde dies bitte dem App Entwickler";
const String NO_AUTH_KEY_GIVEN_FAILURE_MESSAGE =
    "Es scheint als stimmt dein Auth Key nicht, bitte melde dich erneut an und versuche es erneut";

/// Auch wenn es komplett andere Fehler sind, ist die Nachricht für den Nutzer
/// gleich, da der Fehler auf die gleiche Sache hinausläuft die der Nutzer machen
/// kann um den Fehler zu beheben
const String WRONG_CREDENTIALS_FAILURE_MESSAGE =
    NO_AUTH_KEY_GIVEN_FAILURE_MESSAGE;

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final AddNote addNote;
  final ChangeNote changeNote;
  final DeleteNote deleteNote;
  final GetAllNotes getAllNotes;
  final GetNote getNote;

  NotesBloc(
      {@required this.addNote,
      @required this.changeNote,
      @required this.deleteNote,
      @required this.getAllNotes,
      @required this.getNote})
      : assert(addNote != null),
        assert(changeNote != null),
        assert(deleteNote != null),
        assert(getAllNotes != null),
        assert(getNote != null);
  @override
  List<Object> get props =>
      [addNote, changeNote, deleteNote, getAllNotes, getNote];

  @override
  Stream<NotesState> mapEventToState(
    NotesEvent event,
  ) async* {
    if (event is AddNoteEvent) {
      yield NoteLoading();
      final failureOrSuccess = await addNote(event.title, event.note);
      yield* _eitherSuccessOrErrorState(failureOrSuccess);
    } else if (event is ChangeNoteEvent) {
      yield NoteLoading();
      final failureOrSuccess = await changeNote(event.id, event.note);
      yield* _eitherSuccessOrErrorState(failureOrSuccess);
    } else if (event is DeleteNoteEvent) {
      yield NoteLoading();
      final failureOrSuccess = await deleteNote(event.id);
      yield* _eitherSuccessOrErrorState(failureOrSuccess);
    } else if (event is GetNotesEvent) {
      yield NoteLoading();
      final failureOrNotes = await getAllNotes();
      yield* _eitherNotesListOrErrorState(failureOrNotes);
    } else if (event is GetNoteEvent) {
      yield NoteLoading();
      final failureOrNote = await getNote(event.id);
      yield* _eitherNoteOrErrorState(failureOrNote);
    } else if (event is NoteInitialEvent) {
      yield NotesInitial();
    }
  }

  Stream<NotesState> _eitherSuccessOrErrorState(
      Either<Failure, Success> failureOrSuccess) async* {
    yield failureOrSuccess.fold(
        (failure) => NoteError(error: _mapFailureToMessage(failure)),
        (success) => NoteSuccessfull());
  }

  Stream<NotesState> _eitherNotesListOrErrorState(
      Either<Failure, NotesList> failureOrNotes) async* {
    yield failureOrNotes.fold(
        (failure) => NoteError(error: _mapFailureToMessage(failure)),
        (notes) => NotesGot(notes: notes));
  }

  Stream<NotesState> _eitherNoteOrErrorState(
      Either<Failure, Note> failureOrNote) async* {
    yield failureOrNote.fold(
        (failure) => NoteError(error: _mapFailureToMessage(failure)),
        (note) => NoteGot(note: note));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case WrongCredentialsFailure:
        return WRONG_CREDENTIALS_FAILURE_MESSAGE;
      case NoAuthKeyGivenFailure:
        return NO_AUTH_KEY_GIVEN_FAILURE_MESSAGE;
      case ArgsMissingFailure:
        return ARGS_MISSING_FAILURE_MESSAGE;
      default:
        return "Unknown error";
    }
  }

  @override
  NotesState get initialState => NotesInitial();
}
