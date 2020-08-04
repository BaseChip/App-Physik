import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/util/input_converter.dart';
import '../../domain/entities/plot_filename.dart';
import '../../domain/usecases/get_beugungsmuster_plot.dart';

part 'beugungsmuster_plot_event.dart';
part 'beugungsmuster_plot_state.dart';

const String SERVER_FAILURE_MESSAGE = "Server Fehler";
const String CACHE_FAILURE_MESSAGE = "Es scheint als wärst du offline, doch für diese Funktion wird eine Internetverbindung benötigt :(";
const String INVALID_INPUT_FAILURE_MESSAGE = "Eingabe Fehler - bitte überprüf deine Eingaben";

class BeugungsmusterPlotBloc extends Bloc<BeugungsmusterPlotEvent, BeugungsmusterPlotState> {
  final GetBeugungsmusterPlot getBeugungsmusterPlot;
  final InputConverter inputConverter;

  /// Da getBeugungsmusterPot etwas lang für einen benannten Parameter wäre habe ich es mal etwas umständlicher gemacht
  /// Da der Plot und der Input Converter niemals null sein dürfen und ich das später nicht immer einzeln überprüfen
  /// möchte wird direkt beim Konstruktor der Klasse überprüft, dass diese nicht null sind (dies muss über assert passieren,
  /// da Dart keine non nullable Objekte besitzt) 
  BeugungsmusterPlotBloc({
    @required GetBeugungsmusterPlot plot,
    @required this.inputConverter}) : 
      assert(plot != null),
      assert(inputConverter != null),
      getBeugungsmusterPlot = plot;


  @override
  BeugungsmusterPlotState get initialState => BeugungsmusterPlotEmpty();

  /// Alle Parameter die zum erzeugen des Plots notwendig sind wurden aus den Textfeldern als String ausgelesen, aber
  /// in unserer Api möchten wir nur mit Integern und Double Werten arbeiten, daher werden die Werte erst mit der Klasse
  /// InputConverter in ein int oder double umgewandelt und anschließend wird auf mögliche geworfene Fehler, beim
  /// umwandeln der Strings ([ConvertError]) geprüft und falls es Fehler gibt wird das dem Bloc mitgeteilt
  /// 
  /// Ich weiß die Funktion ist mega hässlich verschachtelt und mega kacke zum lesen, aber leider konnte dies schlecht in eine
  /// andere Methode ausgelagert werden, da Blocs Stream sonst an der ein oder anderen stelle nicht mit klar kommt und viele
  /// Error im Stream erzeugt werden können, und es viel mehr aufwand wäre auf die ganzen Fegler zu überprüfen
  @override
  Stream<BeugungsmusterPlotState> mapEventToState(
    BeugungsmusterPlotEvent event,
  ) async* {
    if(event is GetPlotForBeugungsmuster){
      final spaltanzahl = inputConverter.stringToUnsignedInteger(event.spaltanzahl);
      yield* spaltanzahl.fold((failure) async *{yield BeugungsmusterPlotError(error: INVALID_INPUT_FAILURE_MESSAGE);}, (_spaltanzahl) async* {
        final spaltabstand = inputConverter.stringToUnsignedDouble(event.spaltabstand);
        yield* spaltabstand.fold((failure) async *{yield BeugungsmusterPlotError(error: INVALID_INPUT_FAILURE_MESSAGE);}, (_spaltabstand) async* {
          final wellenlaenge = inputConverter.stringToUnsignedDouble(event.wellenleange);
          yield* wellenlaenge.fold((failure) async *{yield BeugungsmusterPlotError(error: INVALID_INPUT_FAILURE_MESSAGE);}, (_wellenlaenge) async* {
            final amplitude = inputConverter.stringToUnsignedDouble(event.amplitude);
            yield* amplitude.fold((failure) async *{yield BeugungsmusterPlotError(error: INVALID_INPUT_FAILURE_MESSAGE);}, (_amplitude) async* {
              yield BeugungsmusterPlotLoading();
              final failureOrFilename = await getBeugungsmusterPlot(Params(spaltanzahl: _spaltanzahl, spaltabstand: _spaltabstand, wellenlaenge: _wellenlaenge, amplitude: _amplitude));
              yield* _eitherLoadedOrErrorState(failureOrFilename);
            });
          });
        });
      });
    }else{
      yield BeugungsmusterPlotEmpty();
    }
  }
  Stream<BeugungsmusterPlotState> _eitherLoadedOrErrorState(
    Either<Failure, PlotFileName> failureOrFilename,
    ) async* {
    yield failureOrFilename.fold(
      (failure) => BeugungsmusterPlotError(error: _mapFailureToMessage(failure)),
      (filename) => BeugungsmusterPlotLoaded(filename: filename),
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
}
