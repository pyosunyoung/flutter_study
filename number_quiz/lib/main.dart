import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

/// 홈 페이지
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

//**StatefulWidget**이 위젯트리에 추가 될 때부터 삭제 될 때까지의 흐름을 **생명 주기(life cycle)**라고 부르고,
// 각 시점에 따라 호출되는 약속된 함수들이 있습니다.
// `initState` : 위젯 생성시 호출
// `dispose` : 위젯 삭제시 호출
class _HomePageState extends State<HomePage> {
  String quiz = "";

  @override
  void initState() {
    // 앱 처음 실행될 떄 실행되는 코드
    super.initState();
    getQuiz();
  }

  //퀴즈 가져오기
  void getQuiz() async {
    //initState에서는 await를 사용할 수 없어서 따로 함수를 만들어서 호출하는 방식으로 설정.
    String trivia = await getNumberTrivia();
    setState(() {
      quiz = trivia;
    });
  }

  /// Numbers API 호출하기
  Future<String> getNumberTrivia() async {
    // get 메소드로 URL 호출
    Response result = await Dio().get(
      'http://www.number-trivia.com/random/trivia',
    );
    String trivia = result.data; // 응답 결과 가져오기
    print(trivia);
    return trivia;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // quiz
              Expanded(
                child: Center(
                  child: Text(
                    quiz,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28, color: Colors.white),
                  ),
                ),
              ),
              // New Quiz 버튼
              SizedBox(
                height: 42,
                child: ElevatedButton(
                  child: Text(
                    "New Quiz",
                    style: TextStyle(color: Colors.pinkAccent, fontSize: 24),
                  ),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    // New Quiz 클릭시 퀴즈 가져오기
                    getQuiz(); // 갱신
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
