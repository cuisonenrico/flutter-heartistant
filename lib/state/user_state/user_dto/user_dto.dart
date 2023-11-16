import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    String? email,
    String? uid, // primary key
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  factory UserDto.fromFirestoreUser(User user) => UserDto(
        email: user.email,
        uid: user.uid,
      );

  factory UserDto.init() => const UserDto();
}
