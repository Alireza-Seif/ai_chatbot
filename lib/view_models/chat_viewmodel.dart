import 'package:ai_chatbot/models/message_model.dart';
import 'package:get/get.dart';

class ChatViewModel extends GetxController {
  var messages = <MessageModel>[].obs;

  void addMessage({required String message, required bool isFromUser}){
    messages.add(MessageModel(message: message, isFromUser: isFromUser));
  }
}
