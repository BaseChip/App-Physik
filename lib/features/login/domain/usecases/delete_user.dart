import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/success/succes.dart';
import '../repositories/login_repository.dart';

class DeleteUser {
  final LoginRepository repository;
  DeleteUser({@required this.repository});

  @override
  Future<Either<Failure, Success>> call(String auth_key) async {
    return await repository.delete_user(auth_key);
  }
}
