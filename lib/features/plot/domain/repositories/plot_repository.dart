import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/plot_filename.dart';


abstract class PlotRepository{
  Future<Either<Failure, PlotFileName>> getBeugungsmusterPlot(int spaltanzahl, double spaltabstand, double wellenlaenge, double amplitude);
}