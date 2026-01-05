import 'package:flutter/material.dart';

/// Starbucks 메인 색상
Color starbucksPrimaryColor = Color.fromARGB(255, 83, 184, 138);

/// Starbucs 포인트 색상
Color starbucksAccentColor = Color.fromARGB(255, 199, 176, 121);

class Starbucks extends StatefulWidget {
  const Starbucks({Key? key}) : super(key: key);

  @override
  _StarbucksState createState() => _StarbucksState();
}

class _StarbucksState extends State<Starbucks> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex, // index 순서에 해당하는 child를 맨 위에 보여줌
        children: [
          StarbucksFirstPage(),
          StarbucksSecondPage(),
          StarbucksThirdPage(),
          Center(child: Text("Starbucks 네 번째 페이지")),
          Center(child: Text("Starbucks 다섯 번째 페이지")),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex, // 현재 보여주는 탭
        onTap: (newIndex) {
          print("selected newIndex : $newIndex");
          // 다른 페이지로 이동
          setState(() {
            currentIndex = newIndex;
          });
        },
        selectedItemColor: starbucksPrimaryColor, // 선택된 아이콘 색상
        unselectedItemColor: Colors.grey, // 선택되지 않은 아이콘 색상
        showSelectedLabels: false, // 선택된 항목 label 숨기기
        showUnselectedLabels: false, // 선택되지 않은 항목 label 숨기기
        type: BottomNavigationBarType.fixed, // 선택시 아이콘 움직이지 않기
        backgroundColor: Colors.white.withOpacity(0.8),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card_rounded),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.free_breakfast), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.redeem), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: ""),
        ],
      ),
    );
  }
}

/// 첫 번째 페이지
class StarbucksFirstPage extends StatelessWidget {
  const StarbucksFirstPage({Key? key}) : super(key: key);

  /// 배경 이미지 URL
  final String backImg =
      "https://devclass.devstory.co.kr/flutter-basic/2/starbucks-bg.png";

  /// Frequency 이미지 URL
  final String frequencyImg =
      "https://devclass.devstory.co.kr/flutter-basic/2/starbucks-frequency.png";

  /// 추천 메뉴
  final List<Map<String, String>> recommendMenu = const [
    {
      "name": "돌체쿠키라떼",
      "imgUrl":
          "https://devclass.devstory.co.kr/flutter-basic/2/starbucks-menu1.jpg",
    },
    {
      "name": "아이스 홀리데이 돌체 쿠키 라떼",
      "imgUrl":
          "https://devclass.devstory.co.kr/flutter-basic/2/ic/2/starbucks-menu2.jpg",
    },
    {
      "name": "스노우 민트 초콜릿",
      "imgUrl":
          "https://devclass.devstory.co.kr/flutter-basic/2/starbucks-menu3.jpg",
    },
    {
      "name": "아이스 스노우 민트 초콜릿",
      "imgUrl":
          "https://devclass.devstory.co.kr/flutter-basic/2/starbucks-menu4.jpg",
    },
    {
      "name": "스노우 민트 초콜릿 블렌디드",
      "imgUrl":
          "https://devclass.devstory.co.kr/flutter-basic/2/starbucks-menu5.jpg",
    },
  ];

  /// 크리스마스 이벤트 이미지 URL
  final String eventImg =
      "https://devclass.devstory.co.kr/flutter-basic/2/starbucks-christmas.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              /// Tip : 스크롤시 배경이 사라지게 만들려면 SliverAppBar 위젯을 사용하면 됩니다.
              /// SliverAppBar에 대한 자세한 내용은 아래 링크를 참고해 주세요.
              /// https://api.flutter.dev/flutter/material/SliverAppBar-class.html
              SliverAppBar(
                automaticallyImplyLeading: false, // 뒤로가기 버튼 숨기기
                pinned:
                    true, // 스크롤시 bottom 영역을 화면 상단에 남길지 여부 Deliverys 버튼 말하는건가
                snap: false, // 중간에 멈출 때 자동으로 AppBar를 펼쳐서 배경을 모두 보여줄지
                floating: true, // AppBar를 화면에 띄울지, 아니면 컬럼처럼 최 상단에 놓을지
                expandedHeight: 252, // 최대 확장되었을 떄 높이
                backgroundColor: Colors.white,

                /// 스크롤시 사라지는 영역 => AppBar 대체?
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode
                      .pin, //배경이 위에 고정됨? => 배경 이미지가 위에 붙은 채로 접히게 하기 위함.
                  background: Stack(
                    // 이미지 안에 뭐가 겹치기 때문. => stack
                    children: [
                      /// 백그라운드 이미지
                      Positioned.fill(
                        bottom: 60,
                        child: Image.network(backImg, fit: BoxFit.fill),
                      ), // 아래쪽 60px 만큼 비워라, 👉 AppBar의 하단 영역(툴바 / 타이틀)과 겹치지 않게 하기 위해, 📌 이미지가 AppBar 버튼 영역 뒤로 안 깔리게
                      /// 배경 위 위젯
                      Positioned(
                        left: 24,
                        right: 24,
                        bottom: 60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "한 해의 마무리,\n수고 많았어요💖",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 32),
                            Row(
                              children: [
                                /// Tip: LinearProgressIndicator가 끝없이 길어지지 않도록 Column의 가로 길이를 Row의 남은 자리만큼만 차지하도록 만들어줌
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "11 ★ until next Reward",
                                        style: TextStyle(
                                          color: starbucksAccentColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 16),

                                      /// Tip : LinearProgressIndicator는 각져있는데, 둥글게 보이도록 모서리를 잘라냄
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        child: LinearProgressIndicator(
                                          backgroundColor: Colors.grey
                                              .withValues(alpha: 0.2),
                                          value: 0.083,
                                          minHeight: 10,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                starbucksAccentColor,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    // 공통 스타일
                                    style: TextStyle(
                                      fontSize: 28,
                                      color: Colors
                                          .black, // RichText는 기본이 흰색이라 안보임
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "1",
                                        style: TextStyle(
                                          fontSize: 38,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " / ",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      TextSpan(
                                        text: "12 ★",
                                        style: TextStyle(
                                          color: starbucksAccentColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// 스크롤시 남아있는 영역
                /// SliverAppBar의 bottom은 PreferredSize 위젯으로 시작해야만 합니다.
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(52),
                  child: Container(
                    height: 52,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, right: 12),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => print("What's New 클릭 됨"),
                            child: Row(
                              children: [
                                Icon(Icons.mail_outline, color: Colors.grey),
                                SizedBox(width: 8),
                                Text(
                                  "What's New",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 32),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 두 번째 페이지
class StarbucksSecondPage extends StatelessWidget {
  const StarbucksSecondPage({Key? key}) : super(key: key);

  /// 카드 이미지
  final String cardImgUrl =
      "https://devclass.devstory.co.kr/flutter-basic/2/starbucks-card.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Starbucks 두 번째 페이지")));
  }
}

/// 세 번째 페이지
class StarbucksThirdPage extends StatelessWidget {
  const StarbucksThirdPage({Key? key}) : super(key: key);

  /// 전체 메뉴
  final List<Map<String, String>> menu = const [
    {
      "ko": "추천",
      "en": "Recommend",
      "imgUrl":
          "https://devclass.devstory.co.kr/flutter-basic/2/starbucks-menu1.jpg",
    },
    {
      "ko": "리저브 에스프레소",
      "en": "Reserve Espresso",
      "imgUrl":
          "https://devclass.devstory.co.kr/flutter-basic/2/ic/2/starbucks-menu2.jpg",
    },
    {
      "ko": "리저브 드립",
      "en": "Reserve Drip",
      "imgUrl":
          "https://devclass.devstory.co.kr/flutter-basic/2/starbucks-menu3.jpg",
    },
    {
      "ko": "콜드브루",
      "en": "ColdBrew",
      "imgUrl":
          "https://devclass.devstory.co.kr/flutter-basic/2/starbucks-menu4.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Starbucks 세 번째 페이지")));
  }
}
