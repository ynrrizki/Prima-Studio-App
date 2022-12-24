import 'package:flutter/material.dart';
import 'package:prima_studio/ui/pages/test/test_chat_page.dart';
import 'package:prima_studio/ui/pages/test/test_video_page.dart';

class TestMainPage extends StatelessWidget {
  const TestMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff1d1c21),
          title: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.chat)),
              Tab(icon: Icon(Icons.video_collection)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TestVideoPage(),
            TestChatPage(),
          ],
        ),
      ),
    );
  }
}
