import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failure.dart';
import '../entities/auth_key_entitie.dart';
import '../repositories/login_repository.dart';

class CreateUser {
  final LoginRepository repository;
  CreateUser({@required this.repository});

  Future<Either<Failure, AuthKey>> call(String email, String pw) async {
    return await repository.createUser(email, pw);
  }
}
