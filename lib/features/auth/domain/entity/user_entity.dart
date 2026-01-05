import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? userName;
  final String email;
  final bool emailVerified;
  final bool isAnonymous;

  const UserEntity({
    this.id,
    this.userName,
    required this.email,
    this.emailVerified = false,
    this.isAnonymous = false,
  });

 
  UserEntity copyWith({
    String? id,
    String? userName,
    String? email,
    bool? emailVerified,
    bool? isAnonymous,
  }) {
    return UserEntity(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      isAnonymous: isAnonymous ?? this.isAnonymous,
    );
  }

  @override
  List<Object?> get props => [id, userName, email, emailVerified, isAnonymous];
}
