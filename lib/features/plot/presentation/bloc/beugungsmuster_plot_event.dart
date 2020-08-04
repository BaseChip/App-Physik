part of 'beugungsmuster_plot_bloc.dart';
@immutable
abstract class BeugungsmusterPlotEvent extends Equatable {
   @override
  List<Object> get props => [];
}
 class GetPlotForBeugungsmuster extends BeugungsmusterPlotEvent{
   final String spaltanzahl;
   final String spaltabstand;
   final String wellenleange;
   final String amplitude;

  GetPlotForBeugungsmuster(this.spaltanzahl, this.spaltabstand, this.wellenleange, this.amplitude);
  @override
  List<Object> get props => [spaltanzahl, spaltabstand, wellenleange, amplitude];
 }