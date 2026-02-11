import 'package:ai_chatbot/view_models/chat_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatView extends StatelessWidget {
  final ChatViewModel chatViewModel = Get.put(ChatViewModel());
  ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('chat view')),
        body: Column(children: [Spacer(), _buildInputMessage()]),
      ),
    );
  }

  Widget _buildInputMessage() {
    final TextEditingController textEditingController = TextEditingController();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: 'Enter Your Message',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              chatViewModel.addMessage(
                message: textEditingController.text,
                isFromUser: true,
              );
            },
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
