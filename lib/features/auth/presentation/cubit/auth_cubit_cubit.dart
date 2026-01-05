import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_list/features/auth/domain/entity/user_entity.dart';
import 'package:todo_list/features/auth/domain/repository/auth_repo.dart';

part 'auth_cubit_state.dart';
part 'auth_cubit_cubit.freezed.dart';

@injectable
class AuthCubitCubit extends Cubit<AuthCubitState> {
  final AuthRepo repository;
  UserEntity? currentUser;

  AuthCubitCubit({required this.repository})
      : super(const AuthCubitState.signUpInitial());

  bool get isAnonymousUser => currentUser?.isAnonymous ?? true;  

  Future<void> signUp({
    required String userName,
    required String email,
    required String password,
  }) async {
    emit(const AuthCubitState.signUpLoading());
    final result = await repository.signUp(
      email: email,
      password: password,
      userName: userName,
    );
    result.fold(
      (failure) => emit(const AuthCubitState.signUpFailure('Sign Up Failure!')),
      (user) {
        currentUser = user;
        emit(AuthCubitState.signUpSuccess(user: user));
      },
    );
  }

  Future<void> signIn({
    required String userName,
    required String email,
    required String password,
  }) async {
    emit(const AuthCubitState.signInLoading());
    final result = await repository.signIn(
      email: email,
      password: password,
      userName: userName,
    );
    result.fold(
      (failure) => emit(const AuthCubitState.signInFailure('Sign In Failure!')),
      (user) {
        currentUser = user;
        emit(AuthCubitState.signInSuccess(user: user));
      },
    );
  }

  Future<void> signInAnonymous() async {
    emit(const AuthCubitState.signInAnonymousLoading());
    final result = await repository.signInAnonymous();
    result.fold(
      (_) => emit(const AuthCubitState.signInAnonymousFailure('Anonymous Sign In Failure!')),
      (user) {
        currentUser = user.copyWith(isAnonymous: true);  
        emit(AuthCubitState.signInAnonymousSuccess(user: user));
      },
    );
  }
Future<void> signOut() async {
  if (isAnonymousUser) {
    log("Sign out blocked: Guest mode", name: "AuthCubit");
    return;
  }

  log("Starting real Sign out (registered user)", name: "AuthCubit");
  emit(const AuthCubitState.signOutLoading());

  final result = await repository.signOut();

  result.fold(
    (failure) {
      log("Sign out failed: ${failure.message}", name: "AuthCubit");
      emit(const AuthCubitState.signOutFailure("Error during sign out"));
    },
    (_) {
      log("Sign out success → auto login as Guest", name: "AuthCubit");
      emit(const AuthCubitState.signOutSuccess());
      signInAnonymous();  
    },
  );
}
Future<void> getCurrentUser() async {
  emit(const AuthCubitState.getCurrentUserLoading());

  final result = await repository.getCurrentUser();

  await result.fold(
    (failure) async {
      emit(
        AuthCubitState.getCurrentUserFailure(
          failure.message ?? "Error getting user",
        ),
      );
    },
    (user) async { 
      if (user != null) {
        currentUser = user;
        emit(AuthCubitState.getCurrentUserSuccess(user, canLogout: !isAnonymousUser));
      } else {
        final guestResult = await repository.signInAnonymous();
        await guestResult.fold(
          (failure) async {
            emit(
              AuthCubitState.signInAnonymousFailure(
                failure.message ?? "Anonymous login failed",
              ),
            );
          },
          (guest) async {
            currentUser = guest.copyWith(isAnonymous: true);
            emit(
              AuthCubitState.getCurrentUserSuccess(guest, canLogout: false),
            );
          },
        );
      }
    },
  );
}

}