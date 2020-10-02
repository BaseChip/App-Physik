import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/auth_key_entitie.dart';
import '../../domain/usecases/create_user.dart';
import '../../domain/usecases/delete_user.dart';
import '../../domain/usecases/login.dart';

part 'login_event.dart';
part 'login_state.dart';

const String SERVER_FAILURE_MESSAGE = "Server Fehler";
const String OFFLINE_FAILURE_MESSAGE =
    "Es scheint als wärst du offline, doch für diese Funktion wird eine Internetverbindung benötigt :(";
const String WRONG_CREDENTIELS_FAILURE_MESSAGE =
    "Es scheint als wären deine Anmeldedaten nicht korrekt, versuch es bitte erneut";
const String USER_DOSNT_EXISTS_FAILURE_MESSAGE =
    "Es gibt keinen Nutzer mit den eigegbenen Daten, bitte überprüf deine Eingaben";
const String User_EXISTS_FAILURE_MESSAGE =
    "Zu deiner eingegebenen Email adresse gibt es bereits einen Nutzer, deshalb kann kein neuer angelegt werden, bitte versuch dich anzumelden oder leg einen neuen Account an";
const String CREDENTIELS_NOT_FIT_FAILURE_MESSAGE =
    "Deine Email Adresse oder Password sind ungültig";

/// Die eingabe Email Adresse und das Password werden von der App nicht überprüft, da dies bereits vom Server erledigt wird und [CredentielsNotFitFailure] ausgegben wird
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login login;
  final CreateUser createUser;
  final DeleteUser deleteUser;
  LoginBloc(
      {@required this.login,
      @required this.createUser,
      @required this.deleteUser})
      : assert(login != null),
        assert(createUser != null),
        assert(deleteUser != null);

  List<Object> get props => [];

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is CreateUserEvent) {
      yield LoginLoading();
      final failureOrAuthKey = await createUser(event.email, event.pw);
      yield* _eitherLoadedOrErrorState(failureOrAuthKey);
    } else if (event is LoginUserEvent) {
      yield LoginLoading();
      final failureOrAuthKey = await login(event.email, event.pw);
      yield* _eitherLoadedOrErrorState(failureOrAuthKey);
    } else if (event is DeleteUserEvent) {
      yield LoginLoading();
      final failureOrSuccess = await deleteUser(event.authkey);
      yield failureOrSuccess.fold(
          (failure) => LoginError(error: _mapFailureToMessage(failure)),
          (success) => DeleteSuccess());
    } else if (event is UserInitialEvent) {
      yield LoginInitial();
    }
  }

  Stream<LoginState> _eitherLoadedOrErrorState(
    Either<Failure, AuthKey> failureOrAuthKey,
  ) async* {
    yield failureOrAuthKey.fold(
      (failure) => LoginError(error: _mapFailureToMessage(failure)),
      (key) => LoginSuccessfull(authkey: key),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case WrongCredentialsFailure:
        return WRONG_CREDENTIELS_FAILURE_MESSAGE;
      case UserDosntExistFailure:
        return USER_DOSNT_EXISTS_FAILURE_MESSAGE;
      case UserExistsFailure:
        return User_EXISTS_FAILURE_MESSAGE;
      case CredentialsNotFitException:
        return CREDENTIELS_NOT_FIT_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }

  @override
  LoginState get initialState => LoginInitial();
}
