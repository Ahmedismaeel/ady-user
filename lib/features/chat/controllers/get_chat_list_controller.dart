import 'package:flutter_sixvalley_ecommerce/features/chat/controllers/chat_type_enum.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/domain/models/chat_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_chat_list_controller.g.dart';

@riverpod
Future<ChatModel> getChatList(GetChatListRef ref,
    {required ChatType type, required int offset}) async {
  return await '${AppConstants.chatInfoUri}${type.name}?limit=1000&offset=$offset'
      .get(fromJson: ChatModel.fromJson);
}
