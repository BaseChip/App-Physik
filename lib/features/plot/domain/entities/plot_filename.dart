
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PlotFileName extends Equatable{
  final String filename;

  PlotFileName({
    @required this.filename,
    });

  @override
  List<Object> get props => [filename];
}