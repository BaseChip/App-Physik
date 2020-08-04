import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/platform/networkinfo.dart';
import '../../domain/entities/articel_entitie.dart';
import '../../domain/entities/articels_list_entitie.dart';
import '../../domain/entities/topics_entitie.dart';
import '../../domain/repositories/content_repository.dart';
import '../datasources/content_api.dart';

/// Ruft die übergebene [ContentApi] auf und liefert die gefragten Infos zurück.
/// Bei jedem Fehler wird ein [ServerFailure] zuürck gegeben
/// Wenn der Nutzer offline ist wird ein [CacheFailure] zurück gegben
class ContentRepositoryImpl implements ContentRepository{
  final ContentApi remoteDataSource;
  final NetworkInfo networkInfo;

  ContentRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });

  @override
  Future<Either<Failure, ArticelsList>> getAllArticels(int id) async {
      if(await networkInfo.isConnected){
        try{
          return Right(await remoteDataSource.getAllArticels(id));
        } on ServerException{
          return Left(ServerFailure());
        }
      }else{
        return Left(CacheFailure());
      }
    }
  
    @override
    Future<Either<Failure, Topics>> getAllTopics() async{
      if(await networkInfo.isConnected){
        try{
          return Right(await remoteDataSource.getAllTopics());
        } on ServerException{
          log("Error: Server Fehler (GetAllTopics)");
          return Left(ServerFailure());
        }
      }else{
        return Left(CacheFailure());
      }
    }

  @override
  Future<Either<Failure, Articel>> getArticel(int id) async{
          if(await networkInfo.isConnected){
        try{
          return Right(await remoteDataSource.getArticel(id));
        } on ServerException{
          return Left(ServerFailure());
        }
      }else{
        return Left(CacheFailure());
      }
  }
}