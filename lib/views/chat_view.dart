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
        appBar: AppBar(
          title: Text('ChatBot 💻'),
          centerTitle: true,
          backgroundColor: Colors.blue[400],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: chatViewModel.messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final message = chatViewModel.messages[index];
                    return Align(
                      alignment: message.isFromUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: message.isFromUser
                              ? Colors.blue[400]
                              : Colors.grey[400],
                          borderRadius: message.isFromUser
                              ? BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                )
                              : BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                        ),
                        child: Text(
                          message.text,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            _buildInputMessage(),
          ],
        ),
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
                isFromUser: false,
              );
              textEditingController.clear();
            },
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
