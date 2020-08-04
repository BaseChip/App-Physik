import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/articel_entitie.dart';
import '../entities/articels_list_entitie.dart';
import '../entities/topics_entitie.dart';

abstract class ContentRepository{
  Future<Either<Failure, Topics>> getAllTopics();
  Future<Either<Failure, ArticelsList>> getAllArticels(int id);
  Future<Either<Failure, Articel>> getArticel(int id);
}