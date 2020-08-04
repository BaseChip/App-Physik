import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failure.dart';
import '../entities/articels_list_entitie.dart';
import '../repositories/content_repository.dart';

class GetAllArticels {
  final ContentRepository repository;
  GetAllArticels({@required this.repository});

  @override
  Future<Either<Failure, ArticelsList>> call(int id) async {
    return await repository.getAllArticels(id);
  }
}
