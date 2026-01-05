import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_list/core/errors/failurs.dart';
import 'package:todo_list/core/usecases/usecase.dart';
import 'package:todo_list/features/auth/domain/entity/user_entity.dart';
import 'package:todo_list/features/auth/domain/repository/auth_repo.dart';
@injectable
class SignInUsecase implements Usecase<UserEntity, SignInParams> {
  final AuthRepo repository;
  SignInUsecase({required this.repository});
  @override
  Future<Either<Failure, UserEntity>> call(SignInParams params) {
    return repository.signIn(
      email: params.email,
      password: params.password,
      userName: params.userName,
    );
  }
}

class SignInParams extends Equatable {
  final String email;
  final String password;
  final String userName;
  const SignInParams({
    required this.email,
    required this.password,
    required this.userName,
  });
  @override
  List<Object?> get props => [email, password, userName];
}
