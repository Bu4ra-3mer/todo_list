import 'package:dartz/dartz.dart';
import 'package:todo_list/core/errors/failurs.dart';
import 'package:todo_list/features/auth/domain/entity/user_entity.dart';


abstract class AuthRepo {
  
  Future<Either<Failure, UserEntity>> signUp({
    required String userName,
    required String email,
    required String password,
  });


  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
    required String userName,
  });
Future<Either<Failure, UserEntity>> signInAnonymous();



  Future<Either<Failure, void>> signOut();
  
  Future<Either<Failure, UserEntity?>> getCurrentUser();

}
