import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/success/succes.dart';
import '../entities/auth_key_entitie.dart';

abstract class LoginRepository {
  Future<Either<Failure, AuthKey>> login(String email, String pw);
  Future<Either<Failure, AuthKey>> create_user(String email, String pw);
  Future<Either<Failure, Success>> delete_user(String auth_key);
}
