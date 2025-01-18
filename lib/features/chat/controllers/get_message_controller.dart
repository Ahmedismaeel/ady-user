import 'package:flutter_sixvalley_ecommerce/features/chat/domain/models/message_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_message_controller.g.dart';

@riverpod
Future<List<MessageModel>> getMessageList(GetMessageListRef ref,
    {required String type, required int? id, required int offset}) async {
  return await '${AppConstants.messageUri}$type/$id?limit=3000&offset=$offset'
      .getList(fromJson: MessageModel.fromJson);
}
