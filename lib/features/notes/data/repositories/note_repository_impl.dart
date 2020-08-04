import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/platform/networkinfo.dart';
import '../../../../core/success/succes.dart';
import '../../domain/entities/note_entitie.dart';
import '../../domain/entities/notes_list_entitie.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/note_api.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteApi remoteDataSource;
  final NetworkInfo networkInfo;

  NoteRepositoryImpl(
      {@required this.remoteDataSource, @required this.networkInfo});
  @override
  Future<Either<Failure, Success>> addNote(String title, String note) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.addNote(title, note));
      } on ArgsMissingException {
        return Left(ArgsMissingFailure());
      } on NoAuthKeyGivenException {
        return Left(NoAuthKeyGivenFailure());
      } on WrongCredentialsException {
        return Left(WrongCredentialsFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Success>> changeNote(String note, int id) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.changeNote(note, id));
      } on ArgsMissingException {
        return Left(ArgsMissingFailure());
      } on NoAuthKeyGivenException {
        return Left(NoAuthKeyGivenFailure());
      } on WrongCredentialsException {
        return Left(WrongCredentialsFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Success>> deleteNote(int id) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.deleteNote(id));
      } on ArgsMissingException {
        return Left(ArgsMissingFailure());
      } on NoAuthKeyGivenException {
        return Left(NoAuthKeyGivenFailure());
      } on WrongCredentialsException {
        return Left(WrongCredentialsFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, NotesList>> getAllNotes() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.getNotes());
      } on ArgsMissingException {
        return Left(ArgsMissingFailure());
      } on NoAuthKeyGivenException {
        return Left(NoAuthKeyGivenFailure());
      } on WrongCredentialsException {
        return Left(WrongCredentialsFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Note>> getNote(int id) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.getNote(id));
      } on ArgsMissingException {
        return Left(ArgsMissingFailure());
      } on NoAuthKeyGivenException {
        return Left(NoAuthKeyGivenFailure());
      } on WrongCredentialsException {
        return Left(WrongCredentialsFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
