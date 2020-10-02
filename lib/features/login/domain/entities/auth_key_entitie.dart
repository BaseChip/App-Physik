import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class AuthKey extends Equatable {
  final String authKey;

  AuthKey({@required this.authKey});
  @override
  List<Object> get props => [authKey];
}
