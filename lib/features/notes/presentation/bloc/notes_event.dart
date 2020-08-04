part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NoteInitialEvent extends NotesEvent {}

class AddNoteEvent extends NotesEvent {
  final String title, note;
  AddNoteEvent({@required this.title, @required this.note});

  @override
  List<Object> get props => [title, note];
}

class ChangeNoteEvent extends NotesEvent {
  final String note;
  final int id;
  ChangeNoteEvent({@required this.id, @required this.note});

  @override
  List<Object> get props => [id, note];
}

class DeleteNoteEvent extends NotesEvent {
  final int id;
  DeleteNoteEvent({@required this.id});

  @override
  List<Object> get props => [id];
}

class GetNoteEvent extends NotesEvent {
  final int id;
  GetNoteEvent({@required this.id});

  @override
  List<Object> get props => [id];
}

class GetNotesEvent extends NotesEvent {}
