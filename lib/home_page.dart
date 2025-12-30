import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/feed.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      "https://devclass.devstory.co.kr/flutter-basic/2/insta-cat1.jpg",
      "https://devclass.devstory.co.kr/flutter-basic/2/insta-cat2.jpg",
      "https://devclass.devstory.co.kr/flutter-basic/2/insta-cat3.jpg",
      "https://devclass.devstory.co.kr/flutter-basic/2/insta-cat4.jpg",
      "https://devclass.devstory.co.kr/flutter-basic/2/insta-cat5.jpg",
      "https://devclass.devstory.co.kr/flutter-basic/2/insta-cat6.jpg",
      "https://devclass.devstory.co.kr/flutter-basic/2/insta-cat7.gif",
    ];
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
      body: ListView.builder(
        //listView는 item 100개가 있을 때 한번에 100개를 빌드하지 않고 화면에 보이는 것부터 아이템을 랜더링함.
        // 즉 스크롤을 내릴 때 마다 동적으로 데이터를 불러와서 최적화하는 기능임.
        itemCount: images.length,
        itemBuilder: (context, index) {
          String image = images[index];
          return Feed(imageUrl: image);
        },
      ),
    );
  }
}

//자주 사용되는 body부분 Feed로 따로 뺴줌 재사용성 증가, extract widget 전구 아니면 컨트롤 + 시프트 + R 하면 됨.
