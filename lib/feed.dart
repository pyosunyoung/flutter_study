import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//자주 사용되는 body부분 Feed로 따로 뺴줌 재사용성 증가, extract widget 전구 아니면 컨트롤 + 시프트 + R 하면 됨.
class Feed extends StatefulWidget {
  // stateless => stateful로 변경 ctrl .상태가 변하기 때문
  const Feed({
    super.key,
    required this.imageUrl, //this는 자기 자신을 가리킴
  }); //Feed(생성자)가 호출될 때 imageUrl에 값을 할당해줄 것.

  final String imageUrl; // 이미지를 담을 변수

  @override
  State<Feed> createState() => _FeedState();
}

//_함수는 이 파일 내부에서만 접근가능한 함수. 즉 외부에서 imageUrl은 위쪽에 값이 삽입 되어 아래 _함수에 imageUrl값이 내려올 것.
class _FeedState extends State<Feed> {
  // 좋아요 여부
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, //기본값은 센터(생략됨)
      children: [
        // 이미지
        Image.network(
          widget.imageUrl,
          height: 400,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(
                CupertinoIcons.heart,
                color: isFavorite ? Colors.pink : Colors.black,
              ),
              onPressed: () {
                setState(() {
                  // setState를 추가해야 화면이 갱신되어서 넣어줘야 함.
                  //setState는 build를 다시 갱신 즉 재실행 해주는 역할.
                  isFavorite = !isFavorite;
                });
              },
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
          child: Text("2 likes", style: TextStyle(fontWeight: FontWeight.bold)),
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
