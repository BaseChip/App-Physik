part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitialEvent extends LoginEvent {}

class CreateUserEvent extends LoginEvent {
  final String email, pw;
  CreateUserEvent({@required this.email, @required this.pw});

  @override
  List<Object> get props => [email, pw];
}

class LoginUserEvent extends LoginEvent {
  final String email, pw;
  LoginUserEvent({@required this.email, @required this.pw});

  @override
  List<Object> get props => [email, pw];
}

class DeleteUserEvent extends LoginEvent {
  final String authkey;
  DeleteUserEvent({@required this.authkey});

  @override
  List<Object> get props => [authkey];
}
