import 'package:ai_chatbot/models/message_model.dart';
import 'package:ai_chatbot/services/api_service.dart';
import 'package:get/get.dart';

class ChatViewModel extends GetxController {
  var messages = <MessageModel>[].obs;
  final ApiService _apiService = ApiService();

  void addMessage({required String message, required bool isFromUser}) {
    messages.add(MessageModel(text: message, isFromUser: isFromUser));
  }

  Future<void> sendMessageToAi(String message) async {
    addMessage(message: message, isFromUser: true);

    try {
      final response = await _apiService.sendMessage(
        message: message,
        conversation: messages.toList(),
      );

      final reply = response['response'] as String;

      addMessage(message: reply, isFromUser: false);
    } catch (ex) {
      addMessage(message: "Error: ${ex.toString()}", isFromUser: false);
    }
  }
}
