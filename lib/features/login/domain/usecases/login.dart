import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failure.dart';
import '../entities/auth_key_entitie.dart';
import '../repositories/login_repository.dart';

class Login {
  final LoginRepository repository;
  Login({@required this.repository});

  Future<Either<Failure, AuthKey>> call(String email, String pw) async {
    return await repository.login(email, pw);
  }
}
