import 'package:flutter_heartistant/state/chat_page_state/chat_room_dto/chat_room_dto.dart';
import 'package:flutter_heartistant/state/user_state/user_dto/user_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_page_state.freezed.dart';
part 'chat_page_state.g.dart';

@freezed
class ChatPageState with _$ChatPageState {
  const factory ChatPageState({
    @Default([]) List<UserDto> userList,
    @Default([]) List<ChatRoomDto> chatRooms,
  }) = _ChatPageState;

  factory ChatPageState.fromJson(Map<String, dynamic> json) => _$ChatPageStateFromJson(json);

  factory ChatPageState.init() => const ChatPageState();
}
