import 'package:flutter_heartistant/state/chat_page_state/chat_dto/chat_dto.dart';
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
    @JsonKey(includeFromJson: false) @Default([]) List<ChatDto> messages,
  }) = _ChatRoomDto;

  factory ChatRoomDto.fromJson(Map<String, dynamic> json) => _$ChatRoomDtoFromJson(json);

  factory ChatRoomDto.init() => ChatRoomDto(
        roomId: null,
        roomCreatorId: null,
        recipientId: null,
        creationDate: null,
        messages: List.empty(),
      );
}
