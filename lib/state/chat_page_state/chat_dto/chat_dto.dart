import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_dto.freezed.dart';
part 'chat_dto.g.dart';

@freezed
class ChatDto with _$ChatDto {
  const factory ChatDto({
    String? senderId,
    String? message,
    String? date,
  }) = _ChatDto;

  factory ChatDto.fromJson(Map<String, dynamic> json) => _$ChatDtoFromJson(json);

  factory ChatDto.init() => const ChatDto(
        senderId: null,
        message: null,
        date: null,
      );
}
