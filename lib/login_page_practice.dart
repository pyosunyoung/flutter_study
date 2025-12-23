import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: Scaffold(
        //14~16 화면에 보일 영역
        appBar: AppBar(
          //네브바 영역
          title: Text('Hello Flutter', style: TextStyle(fontSize: 28)),
          centerTitle: true, // 가운데 정렬
        ), //
        body: SingleChildScrollView(
          // 이미지 떄문에 화면 넘쳐서 해당 화면 스크롤 적용
          child: Padding(
            //padding 위젯 알지?
            padding: const EdgeInsets.all(
              16.0,
            ), // EdgeInsets all전방위 모두 동일하게 적용, only 특정 방위만, symmetric 위아래, 좌우 적용
            child: Column(
              //컨트롤 + 스페이스를 누르면 자동 완성 옵션 나옴.
              // 컨트롤 + shift + r => 컬럼 설정.
              children: [
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Image.network(
                    "https://devclass.devstory.co.kr/flutter-basic/1/cat.png",
                    width: 81,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(labelText: '이메일'),
                ), //텍스트 입력
                TextField(
                  obscureText: true, // 비밀번호 형식으로 설정.
                  decoration: InputDecoration(labelText: '비밀번호'),
                ), //텍스트 입력
                Container(
                  // container는 높이, 폭, 박스 색상등을 줄 수 있음
                  width: double.infinity, //기기 마다 해당 화면에 꽉 채우기, 부모 한도
                  margin: const EdgeInsets.only(top: 16), // 위에만 마진 넣기
                  child: ElevatedButton(onPressed: () {}, child: Text('로그인')),
                ),
              ],
            ),
          ),
        ), //,에 따라 줄정렬이 된다.
      ),
    );
  }
}
