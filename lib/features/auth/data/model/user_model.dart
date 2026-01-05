
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:todo_list/core/auth_user.dart';
import 'package:todo_list/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    String? id,

    required super.userName,
    required super.email,
    super.emailVerified,
    super.isAnonymous = false,
  }) : super(id: id);
factory UserModel.fromParseUser(ParseUser user) {
  final isAnonymous = user.get<bool>('isAnonymous') ?? false;

  return UserModel(
    id: user.objectId ?? "",
    userName: isAnonymous ? "Guest" : user.get<String>('username') ?? "",
    email: user.get<String>('email') ?? "",
    emailVerified: user.get<bool>('emailVerified') ?? false,
    isAnonymous: isAnonymous,
  );
}


 AuthUser toAuthUser(String password) {
  final user = AuthUser(userName ?? "Guest", password, email);
  return user;
}

}
