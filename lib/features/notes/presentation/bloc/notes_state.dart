part of 'notes_bloc.dart';

abstract class NotesState extends Equatable {
  @override
  List<Object> get props => [];
}

class NotesInitial extends NotesState {}

/// Benutzt für: Add Note, Change Note, Delete Note
class NoteSuccessfull extends NotesState {}

class NoteLoading extends NotesState {}

class NoteGot extends NotesState {
  final Note note;

  NoteGot({@required this.note});
  @override
  List<Object> get props => [note];
}

class NotesGot extends NotesState {
  final NotesList notes;

  NotesGot({@required this.notes});
  @override
  List<Object> get props => [notes];
}

class NoteError extends NotesState {
  final String error;
  NoteError({@required this.error});
  @override
  List<Object> get props => [error];
}
