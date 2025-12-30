import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//자주 사용되는 body부분 Feed로 따로 뺴줌 재사용성 증가, extract widget 전구 아니면 컨트롤 + 시프트 + R 하면 됨.
class Feed extends StatefulWidget { // stateless => stateful로 변경 ctrl .상태가 변하기 때문
  const Feed({
    super.key,
  });

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, //기본값은 센터(생략됨)
      children: [
        // 이미지
        Image.network(
          "https://devclass.devstory.co.kr/flutter-basic/2/cat.png",
          height: 400,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(CupertinoIcons.heart, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(CupertinoIcons.chat_bubble, color: Colors.black),
              onPressed: () {},
            ),
            Spacer(), //빈 공간을 차지하는 위젯.
            IconButton(
              icon: Icon(CupertinoIcons.bookmark, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
    
        // 좋아요
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "2 likes",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
    
        // 설명
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "My cat is docile even when bathed. I put a duck on his head in the wick and he's staring at me. Isn't it so cute??",
          ),
        ),
    
        // 날짜
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("FEBURARY 6", style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}