import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/topics_entitie.dart';
import '../repositories/content_repository.dart';

class GetAllTopics implements UseCases<Topics, NoParams>{
  final ContentRepository repository;
  GetAllTopics(this.repository);

  @override
  Future<Either<Failure, Topics>> call(NoParams params) async {
    log("Called: GetAllTopics");
    return await repository.getAllTopics();
  }
}