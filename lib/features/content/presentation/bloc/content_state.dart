part of 'content_bloc.dart';

/// Eine Klasse die alle mäglichen States des UIs behandelt, welche im zusammenhang
/// zum content Feature stehen
@immutable
abstract class ContentState extends Equatable{
  @override
  List<Object> get props => [];
}

class ContentInitial extends ContentState {}
class ContentLoading extends ContentState{}
class ContentError extends ContentState{
  final String error;
  ContentError({@required this.error});

  @override
  List<Object> get props => [error];
}
class ArticelsLoaded extends ContentState{
  final ArticelsList articels;

  ArticelsLoaded({@required this.articels});
  @override
  List<Object> get props => [articels];
}
class ArticelLoaded extends ContentState{
  final Articel articel;

  ArticelLoaded({@required this.articel});
  @override
  List<Object> get props => [articel];
}
class TopicsLoaded extends ContentState{
  final Topics topics;

  TopicsLoaded({@required this.topics});
  @override
  List<Object> get props => [topics];
}
