part of 'beugungsmuster_plot_bloc.dart';

@immutable
abstract class BeugungsmusterPlotState extends Equatable {
  //const BeugungsmusterPlotState();
  @override
  List<Object> get props => [];
}

class BeugungsmusterPlotInitial extends BeugungsmusterPlotState {}
class BeugungsmusterPlotEmpty extends BeugungsmusterPlotState {}
class BeugungsmusterPlotLoading extends BeugungsmusterPlotState {}
class BeugungsmusterPlotLoaded extends BeugungsmusterPlotState {
  final PlotFileName filename;
  BeugungsmusterPlotLoaded({@required this.filename});
  @override
  List<Object> get props => [filename];
}
class BeugungsmusterPlotError extends BeugungsmusterPlotState {
  final String error;
  BeugungsmusterPlotError({@required this.error});
  @override
  List<Object> get props => [error];
}
