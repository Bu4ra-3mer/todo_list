import 'dart:developer';
import 'package:injectable/injectable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:todo_list/core/auth_user.dart';
import 'package:todo_list/core/errors/exception.dart';
import 'package:todo_list/features/auth/data/model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signUp(UserModel user, String password);

  Future<UserModel> signIn(String userName, String email, String password);
  Future<UserModel> signInAnonymous();

  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> signIn(
    String userName,
    String email,
    String password,
  ) async {
    log("Starting signIn()", name: "AuthRemoteDataSource");
    final authUser = AuthUser(userName, password, email);
    log(
      "Created auther with username$userName,password$password,email$email",
      name: "AuthRemoteDataSource",
    );
    final response = await authUser.login();
    log(
      "login responce success=${response.success} ,result=${response.result}",
      name: "AuthRemoteDataSource",
    );
    if (response.success && response.result != null) {
      final userModel = UserModel.fromParseUser(response.result);
      log(
        "UserModel created: id=${userModel.id}, username=${userModel.userName}, email=${userModel.email}, isAnonymous=${userModel.isAnonymous}",
        name: "AuthRemoteDataSource",
      );
      return userModel;
    } else {
      log(
        "Login failed with error: ${response.error?.message}",
        name: "AuthRemoteDataSource",
      );
      throw ServerException(message: response.error?.message ?? "Login Failed");
    }
  }

  @override
  Future<void> signOut() async {
    log("starting sign out ", name: "AuthRemoteDataSource");
    final currentUser = await ParseUser.currentUser();
    if (currentUser != null) {
      await currentUser.logout();
      log("User logged out successfully", name: "AuthRemoteDataSource");
    } else {
      log("No current user found to log out", name: "AuthRemoteDataSource");
    }
  }

  @override
  Future<UserModel> signUp(UserModel user, String password) async {
    try {
      log("starting sign up ", name: "AuthRemoteDataSource");
      final authUser = user.toAuthUser(password);
      log(
        "Created AuthUser for signUp: ${user.userName},${user.email}",
        name: "AuthRemoteDataSource",
      );
      final response = await authUser.signUp();
      log(
        "SignUp response: success=${response.success}",
        name: "AuthRemoteDataSource",
      );

      if (response.success && response.result != null) {
        final userModel = UserModel.fromParseUser(response.result);
        log(
          "User signed up successfully: ${userModel.userName}",
          name: "AuthRemoteDataSource",
        );
        
        return userModel;
      } else {
        log(
          "SignUp failed: ${response.error?.message}",
          name: "AuthRemoteDataSource",
        );
        throw Exception(response.error?.message ?? "Sign Up Failed");
      }
    } on Exception catch (e) {
      log("Exception in signUp: $e", name: "AuthRemoteDataSource", error: e);
      throw Exception("SignUp Error: ${e.toString()}");
    }
  }

  @override
  Future<UserModel> signInAnonymous() async {
    log("starting sign in anonymous", name: "AuthRemoteDataSource");
    final parseUser = ParseUser(null, null, null);
    final response = await parseUser.loginAnonymous();
    log("sign in anonymous response=${response.success}",name:"AuthRemoteDataSource" );
if (response.success && response.result != null) {
      final userModel = UserModel.fromParseUser(response.result);
      log("Anonymous user logged in: ${userModel.userName}",
          name: "AuthRemoteDataSource");
      return userModel;
    }else {
      log("Anonymous login failed: ${response.error?.message}",
          name: "AuthRemoteDataSource");
      throw ServerException(
        message: response.error?.message ?? "Anonymous Login Failed",
      );
    }
  }

@override
Future<UserModel?> getCurrentUser() async {
  log("Fetching current user", name: "AuthRemoteDataSource");
  final user = await ParseUser.currentUser();
  if (user != null) {
    log("Current user found: ${user.username}", name: "AuthRemoteDataSource");
    return UserModel.fromParseUser(user); 
  }
  log("No current user found", name: "AuthRemoteDataSource");
  return null;
}

}
