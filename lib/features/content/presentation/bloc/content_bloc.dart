import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../../domain/entities/articel_entitie.dart';
import '../../domain/entities/articels_list_entitie.dart';
import '../../domain/entities/topics_entitie.dart';
import '../../domain/usecases/get_all_articels.dart';
import '../../domain/usecases/get_all_topics.dart';
import '../../domain/usecases/get_articel.dart';

part 'content_event.dart';
part 'content_state.dart';

const String SERVER_FAILURE_MESSAGE = "Server Fehler";
const String CACHE_FAILURE_MESSAGE = "Es scheint als wärst du offline, doch für diese Funktion wird eine Internetverbindung benötigt :(";

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  final GetAllArticels getAllArticels;
  final GetAllTopics getAllTopics;
  final GetArticel getArticel;

  /// Da Dart noch keine non nullable Objekte besitzt und keine der Funktionen funktionieren kann,
  /// falls eine Klasse nicht übergeben wird, überprüfe ich noch einmal, dass kein Objekt null ist 
  /// (und somit entweder nicht richtig übergeben wurde oder nicht instanziert)
  /// Dieser Test wird nur hier benötigt, da nach der Clean Architecture nach Uncle Bob der Call Flow
  /// immer nur von der Presentation Ebene kommen kann/darf und somit an keiner anderen Stelle mehr null
  /// Objekte übergben werden können
  ContentBloc({
    @required this.getAllArticels,
    @required this.getAllTopics,
    @required this.getArticel}) : assert(getArticel != null), assert(getAllTopics != null), assert(getAllArticels != null);

  @override
  Stream<ContentState> mapEventToState(
    ContentEvent event,
  ) async* {
    if(event is GetAllArticelsEvent){
      yield ContentLoading();
      final failureOrArticels = await getAllArticels(event.id);
      yield* _eitherLoadedArticelsOrErrorState(failureOrArticels);
    }else if (event is GetAllTopicsEvent){
      yield ContentLoading();
      final failureOrTopics = await getAllTopics(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrTopics);
    } else if(event is GetArticelEvent){
      yield ContentLoading();
      final failureOrArticel = await getArticel(event.id);
      yield* _eitherLoadedArticelOrErrorState(failureOrArticel);
    }
  }

  Stream<ContentState> _eitherLoadedOrErrorState(
    Either<Failure, Topics> failureOrTopics,
    ) async* {
    yield failureOrTopics.fold(
      (failure) => ContentError(error: _mapFailureToMessage(failure)),
      (topic) => TopicsLoaded(topics: topic),
    );
  }

  Stream<ContentState> _eitherLoadedArticelsOrErrorState(
    Either<Failure, ArticelsList> failureOrTopics,
    ) async* {
    yield failureOrTopics.fold(
      (failure) => ContentError(error: _mapFailureToMessage(failure)),
      (articels) => ArticelsLoaded(articels: articels),
    );
  }

  Stream<ContentState> _eitherLoadedArticelOrErrorState(
    Either<Failure, Articel> failureOrTopics,
    ) async* {
    yield failureOrTopics.fold(
      (failure) => ContentError(error: _mapFailureToMessage(failure)),
      (articel) => ArticelLoaded(articel: articel),
    );
  }

  String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}
  /// Legt fest, dass der UrsprungsState [ContentInitial] ist
  @override
  ContentState get initialState => ContentInitial();

  @override
  List<Object> get props => [];
}
