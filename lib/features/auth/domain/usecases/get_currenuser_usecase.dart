import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_list/core/errors/failurs.dart';
import 'package:todo_list/core/usecases/usecase.dart';
import 'package:todo_list/features/auth/domain/entity/user_entity.dart';
import 'package:todo_list/features/auth/domain/repository/auth_repo.dart';
import 'package:todo_list/features/auth/domain/usecases/sign_in_anonymous_usecase.dart';
@injectable
class GetCurrenuserUsecase implements Usecase<UserEntity?, NoParams> {
  final AuthRepo repository;
  const GetCurrenuserUsecase({required this.repository});
  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
