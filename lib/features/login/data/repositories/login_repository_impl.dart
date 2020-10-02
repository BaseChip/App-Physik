import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/platform/networkinfo.dart';
import '../../../../core/success/succes.dart';
import '../../domain/entities/auth_key_entitie.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/user_api.dart';

class LoginRepositoryImpl implements LoginRepository {
  final UserApi remoteDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl(
      {@required this.remoteDataSource, @required this.networkInfo});
  @override
  Future<Either<Failure, AuthKey>> createUser(String email, String pw) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.createUser(email, pw));
      } on ServerException {
        return Left(ServerFailure());
      } on UserExistsException {
        return Left(UserExistsFailure());
      } on CredentialsNotFitException {
        return Left(CrednetialsNotFitFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Success>> deleteUser(String authKey) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.deleteUser(authKey));
      } on WrongCredentialsException {
        return Left(WrongCredentialsFailure());
      } on UserDosntExistException {
        return Left(UserDosntExistFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, AuthKey>> login(String email, String pw) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.login(email, pw));
      } on WrongCredentialsException {
        return Left(WrongCredentialsFailure());
      } on UserDosntExistException {
        return Left(UserDosntExistFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
