import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello Flutter', style: TextStyle(fontSize: 28)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Image.network(
                  "https://devclass.devstory.co.kr/flutter-basic/1/cat.png",
                  width: 81,
                ),
              ),
              const TextField(decoration: InputDecoration(labelText: '이메일')),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(labelText: '비밀번호'),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('로그인'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
