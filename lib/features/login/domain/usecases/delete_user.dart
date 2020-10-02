import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/success/succes.dart';
import '../repositories/login_repository.dart';

class DeleteUser {
  final LoginRepository repository;
  DeleteUser({@required this.repository});

  Future<Either<Failure, Success>> call(String authKey) async {
    return await repository.deleteUser(authKey);
  }
}
