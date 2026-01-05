import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:todo_list/core/errors/exception.dart';
import 'package:todo_list/core/errors/failurs.dart';
import 'package:todo_list/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:todo_list/features/auth/data/model/user_model.dart';
import 'package:todo_list/features/auth/domain/entity/user_entity.dart';
import 'package:todo_list/features/auth/domain/repository/auth_repo.dart';

@Injectable(as: AuthRepo)
class AuthRepositoryImpl implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
    required String userName,
  }) async {
    try {
      final userModel = await remoteDataSource.signIn(
        userName,
        email,
        password,
      );
      return Right(userModel);
    } on ServerException {
      return Left(ServerFailure());
    }
  }@override
Future<Either<Failure, UserEntity>> signOut() async {
  try {
    log("start sign out", name: "AuthRepository");
    await remoteDataSource.signOut(); 
    log("User signed out successfully", name: "AuthRepository");


    return const Right(UserEntity(id: "", userName: "", email: "", emailVerified: false));
  } on ServerException catch (e) {
    return Left(ServerFailure(message: e.message));
  } catch (e) {
    return Left(ServerFailure(message: e.toString()));
  }
}
  @override
  Future<Either<Failure, UserEntity>> signUp({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      final userModel = UserModel(userName: userName, email: email);
      final result = await remoteDataSource.signUp(userModel, password);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

@override
Future<Either<Failure, UserEntity>> signInAnonymous() async {
  try {
    log("start signin anonymous", name: "AuthRepository");

   final currentUser = await ParseUser.currentUser();
if (currentUser != null) {
  await currentUser.logout();
}

    final parseUser = ParseUser(null, null, null);
    final response = await parseUser.loginAnonymous();

    log(
      "Anonymous login response: success=${response.success}, results=${response.results}",
      name: "AuthRepository",
    );

    if (response.success && response.results != null && response.results!.isNotEmpty) {
      final parseUserResult = response.results!.first;

      log(
        "Anonymous login succeeded: userId=${parseUserResult.objectId}",
        name: "AuthRepository",
      );

      return Right(
        UserModel(
          id: parseUserResult.objectId ?? "",
          userName: "Guest",
          email: "",
          emailVerified: false,
          isAnonymous: true,
        ),
      );
    } else {
      final errorMsg = response.error?.message ?? "Anonymous login failed - no results";
      log(errorMsg, name: "AuthRepository");
      return Left(ServerFailure(message: errorMsg));
    }
  } catch (e, stackTrace) {
    log(
      "Exception during anonymous login: $e\n$stackTrace",
      name: "AuthRepository",
    );
    return Left(ServerFailure(
      message: "Failed to sign in anonymously: ${e.toString()}",
    ));
  }
}

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      log("start getCurrentUser ", name: "AuthRepository");
      final result = await remoteDataSource.getCurrentUser();
      log(
        "getCurrentUser results=$result",
        name: "AuthRepository",
      );
      return Right(result);
    } on ServerException catch (e) {
        log(" failed getCurrentUser", name: "AuthRepository");
      return Left(ServerFailure(message: e.message));
    } catch (e) {
       log(
        "ServerException during getCurrentUser: $e",
        name: "AuthRepository",
      );
           log("Unexpected error during getCurrentUser: $e", name: "AuthRepository");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
