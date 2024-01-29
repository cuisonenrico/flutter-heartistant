import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room_dto.freezed.dart';
part 'chat_room_dto.g.dart';

@freezed
class ChatRoomDto with _$ChatRoomDto {
  const factory ChatRoomDto({
    String? roomId,
    String? roomCreatorId,
    String? recipientId,
    String? creationDate,
  }) = _ChatRoomDto;

  factory ChatRoomDto.fromJson(Map<String, dynamic> json) => _$ChatRoomDtoFromJson(json);

  factory ChatRoomDto.init() => const ChatRoomDto(
        roomId: null,
        roomCreatorId: null,
        recipientId: null,
        creationDate: null,
      );
}
