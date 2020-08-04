part of 'content_bloc.dart';

@immutable
abstract class ContentEvent extends Equatable{
  @override
  List<Object> get props => [];
}
class GetAllArticelsEvent extends ContentEvent{
  final int id;

  GetAllArticelsEvent({@required this.id});
  List<Object> get props => [id];
}
// benötigt keinen body, da dafür keine Parameter benötigt sind
class GetAllTopicsEvent extends ContentEvent{}
class GetArticelEvent extends ContentEvent{
  final int id;

  GetArticelEvent({@required this.id});
  List<Object> get props => [id];
}
