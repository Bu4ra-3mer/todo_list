part of 'auth_cubit_cubit.dart';

@freezed
class AuthCubitState with _$AuthCubitState {
  const factory AuthCubitState.signUpInitial() = _SignUpInitial;
  const factory AuthCubitState.signUpLoading() = _SignUpLoading;
  const factory AuthCubitState.signUpSuccess({required UserEntity user}) = _SignUpSuccess;
  const factory AuthCubitState.signUpFailure(String message) = _SignUpFailure;

  const factory AuthCubitState.signInLoading() = _SignInLoading;
  const factory AuthCubitState.signInSuccess({required UserEntity user}) = _SignInSuccess;
  const factory AuthCubitState.signInFailure(String message) = _SignInFailure;

  const factory AuthCubitState.signInAnonymousLoading({UserEntity? user}) =
      _SignInAnonymousLoading;

  const factory AuthCubitState.signInAnonymousSuccess({
    required UserEntity user,
  }) = _SignInAnonymousSuccess;

  const factory AuthCubitState.signInAnonymousFailure(
    String message, {
    UserEntity? user,
  }) = _SignInAnonymousFailure;

  const factory AuthCubitState.signOutLoading() = _SignOutLoading;
  const factory AuthCubitState.signOutSuccess() = _SignOutSuccess;
  const factory AuthCubitState.signOutFailure(String message) = _SignOutFailure;

const factory AuthCubitState.getCurrentUserLoading() = _GetCurrentUserLoading;
const factory AuthCubitState.getCurrentUserSuccess(UserEntity user, {required bool canLogout}) = _GetCurrentUserSuccess;
const factory AuthCubitState.getCurrentUserFailure(String message) = _GetCurrentUserFailure;

}
