import 'package:flutter/material.dart';
import 'package:miso_starbucks/miso.dart';
import 'package:miso_starbucks/starbucks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AppListPage());
  }
}
//OS에 따른 침입(intrusions by the operating system)을 피하기 위해 충분한 패딩(sufficient padding)을 주는 위젯이라고 합니다.
//SafeArea는 또한 기능적으로는 Padding widget과 다를바가 없습니다.
//한가지 차이점은 Padding widget은 강제적으로 padding을 넣는 반면,
//SafeArea는 필요할 때만 넣는다는 것입니다.
class AppListPage extends StatelessWidget {
  const AppListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            /// Miso
            ListTile(
              title: Text("1. Miso", style: TextStyle(fontSize: 24)),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Miso()),
              ),
            ),

            /// Starbucks
            ListTile(
              title: Text("2. StarBucks", style: TextStyle(fontSize: 24)),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Starbucks()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
