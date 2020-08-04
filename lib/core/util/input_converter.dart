import 'package:dartz/dartz.dart';

import '../error/failure.dart';

class InputConverter{
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
  Either<Failure, double> stringToUnsignedDouble(String str) {
    try {
      final doubl = double.parse(str);
      if (doubl < 0.0) throw FormatException();
      return Right(doubl);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }

}
class InvalidInputFailure extends Failure{}