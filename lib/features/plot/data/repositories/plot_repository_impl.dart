import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/platform/networkinfo.dart';
import '../../domain/entities/plot_filename.dart';
import '../../domain/repositories/plot_repository.dart';
import '../datasources/Plot_api.dart';

class PlotRepositoryImpl implements PlotRepository{
  final PlotApi remoteDataSource;
  final NetworkInfo networkInfo;
  PlotRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, PlotFileName>> getBeugungsmusterPlot(int spaltanzahl, double spaltabstand, double wellenlaenge, double amplitude) async {
    if( await networkInfo.isConnected){
      try{
        return Right(await remoteDataSource.getBeugungsmusterPlot(spaltanzahl, spaltabstand, wellenlaenge, amplitude));
      } on ServerException {
        return Left(ServerFailure());
      }
      /// wenn der User offline ist wird aktuell ein [CacheFailure] als Fehler zurück gegeben 
    }else{
      return Left(CacheFailure());
    }
  }

}