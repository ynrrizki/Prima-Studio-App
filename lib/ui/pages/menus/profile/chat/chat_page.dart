import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import '../../../../pages/test/test_chat_page.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Prima Studio'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.orange,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Chat(
          theme: DefaultChatTheme(
            primaryColor: Colors.orange,
            inputBackgroundColor: Colors.white,
            inputTextColor: Colors.black,
            // backgroundColor: Colors.white,
            // sendButtonIcon: Icon(Icons.send),
            inputContainerDecoration: BoxDecoration(
              border: Border.all(
                color: Colors.orange,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          messages: _messages,
          onSendPressed: _handleSendPressed,
          user: _user,
        ),
      ),
    );
  }
}
