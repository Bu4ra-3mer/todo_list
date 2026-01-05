import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_list/core/errors/failurs.dart';
import 'package:todo_list/core/usecases/usecase.dart';
import 'package:todo_list/features/auth/domain/entity/user_entity.dart';
import 'package:todo_list/features/auth/domain/repository/auth_repo.dart';

@injectable

class SignInAnonymousUsecase extends Usecase<UserEntity,NoParams> {
  final AuthRepo repository;
  SignInAnonymousUsecase( this.repository);
  @override
  Future<Either<Failure, UserEntity>> call(params)async {
  return await repository.signInAnonymous();
  }

}
class NoParams extends Equatable{
  @override
  
  List<Object?> get props => [];

}
