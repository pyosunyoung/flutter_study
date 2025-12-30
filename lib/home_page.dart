import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/feed.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          // 맨 왼쪽
          icon: Icon(CupertinoIcons.camera, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            // 맨 오른쪽
            icon: Icon(CupertinoIcons.paperplane, color: Colors.black),
            onPressed: () {},
          ),
        ],
        title: Image.asset('assets/logo.png', height: 32),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Feed(),
    );
  }
}
//자주 사용되는 body부분 Feed로 따로 뺴줌 재사용성 증가, extract widget 전구 아니면 컨트롤 + 시프트 + R 하면 됨.
