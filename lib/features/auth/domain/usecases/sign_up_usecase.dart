import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_list/core/errors/failurs.dart';
import 'package:todo_list/core/usecases/usecase.dart';
import 'package:todo_list/features/auth/domain/entity/user_entity.dart';
import 'package:todo_list/features/auth/domain/repository/auth_repo.dart';
@injectable
class SignUpUsecase implements Usecase<UserEntity, SignUpParams> {
  final AuthRepo repository;
  SignUpUsecase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) {
    return repository.signUp(
      userName: params.userName,
      email: params.email,
      password: params.passWord,
    );
  }
}

class SignUpParams extends Equatable {
  final String userName;
  final String email;
  final String passWord;
  const SignUpParams({
    required this.userName,
    required this.email,
    required this.passWord,
  });
  @override
  List<Object?> get props => [userName, email, passWord];
}
