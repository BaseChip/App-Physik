import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failure.dart';
import '../entities/articel_entitie.dart';
import '../repositories/content_repository.dart';

class GetArticel {
  final ContentRepository repository;
  GetArticel({@required this.repository});

  Future<Either<Failure, Articel>> call(int id) async {
    return await repository.getArticel(id);
  }
}
