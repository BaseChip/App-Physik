import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class AuthKey extends Equatable {
  final String auth_key;

  AuthKey({@required this.auth_key});
  @override
  List<Object> get props => [auth_key];
}
