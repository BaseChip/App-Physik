part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginError extends LoginState {
  final String error;
  LoginError({@required this.error});
  @override
  List<Object> get props => [error];
}

class LoginSuccessfull extends LoginState {
  final AuthKey authkey;
  LoginSuccessfull({@required this.authkey});

  @override
  List<Object> get props => [authkey];
}

class LoginLoading extends LoginState {}

class DeleteSuccess extends LoginState {}
