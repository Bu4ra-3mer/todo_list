import 'package:dartz/dartz.dart';
import 'package:todo_list/core/errors/failurs.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
