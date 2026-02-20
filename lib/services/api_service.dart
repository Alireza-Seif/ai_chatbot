import 'package:ai_chatbot/models/message_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://farchat.onrender.com',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );

  Future<Map<String, dynamic>> sendMessage({
    required String message,
    List<MessageModel>? conversation,
  }) async {

    List<Map<String, dynamic>> convList = [];

    if (conversation != null && conversation.isNotEmpty) {
      List<MessageModel> conversationForApi = List.from(conversation);

      if (conversationForApi.last.isFromUser) {
        conversationForApi.removeLast();
      }

      for (var msg in conversationForApi) {
        convList.add({
          "role": msg.isFromUser ? "user" : "assistant",
          "content": msg.text,
        });
      }
    }

    try {
      final response = await dio.post(
        "/ai",   
        data: {
          "message": message,
          "conversation": convList,
        },
      );

      return response.data; 

    } on DioException catch (e) {
      throw Exception(
        e.response?.data["error"] ?? e.message,
      );
    }
  }
}