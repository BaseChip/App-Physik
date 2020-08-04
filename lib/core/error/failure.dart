import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// Allgemeine Fehler
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

// Login Fehler
class OfflineFailure extends Failure {}

class WrongCredentialsFailure extends Failure {}

class UserExistsFailure extends Failure {}

class CrednetialsNotFitFailure extends Failure {}

class UserDosntExistFailure extends Failure {}

// Note Fehler
class ArgsMissingFailure extends Failure {}

class NoAuthKeyGivenFailure extends Failure {}
