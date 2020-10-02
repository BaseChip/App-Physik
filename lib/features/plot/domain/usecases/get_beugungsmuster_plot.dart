import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failure.dart';
import '../entities/plot_filename.dart';
import '../repositories/plot_repository.dart';

class GetBeugungsmusterPlot {
  final PlotRepository repository;

  GetBeugungsmusterPlot(this.repository);

  Future<Either<Failure, PlotFileName>> call(Params params) async {
    return await repository.getBeugungsmusterPlot(params.spaltanzahl,
        params.spaltabstand, params.wellenlaenge, params.amplitude);
  }
}

class Params extends Equatable {
  final int spaltanzahl;
  final double spaltabstand;
  final double wellenlaenge;
  final double amplitude;

  Params(
      {@required this.spaltanzahl,
      @required this.spaltabstand,
      @required this.wellenlaenge,
      @required this.amplitude});

  @override
  List<Object> get props =>
      [spaltanzahl, spaltabstand, wellenlaenge, amplitude];
}
