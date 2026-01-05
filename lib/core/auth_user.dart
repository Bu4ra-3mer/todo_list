import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class AuthUser extends ParseUser implements ParseCloneable{
  AuthUser(String userName, String password, String email)
    : super(userName, password, email);

  void setCustomColumn(String key, dynamic value) {
    set(key, value);
  }
}
