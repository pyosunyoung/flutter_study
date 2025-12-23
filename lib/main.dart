import 'package:flutter/material.dart';
import 'login_page.dart';
import 'food_recipe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: false), //색깔 변경(검 => 파)
      debugShowCheckedModeBanner: false,
      // home: LoginPage(),
      // 실습할 때 이거로 바꿔치기
      home: FoodRecipe(),
    );
  }
}
