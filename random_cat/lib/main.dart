import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CatService()),
      ], // 생성자 호출
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

/// 고양이 서비스
class CatService extends ChangeNotifier {
  // 고양이 사진 담을 변수
  List<String> catImages = [];

  List<String> favoriteImages = [];
  CatService() {
    //생성자
    getRandomCatImages();
  }

  //랜덤 고양이 사진 API 호출
  void getRandomCatImages() async {
    Response result = await Dio().get(
      "https://api.thecatapi.com/v1/images/search?limit=10&mime_types=jpg",
    );
    print(result.data);
    for (var i = 0; i < result.data.length; i++) {
      var map = result.data[i];
      print(map["url"]);
      catImages.add(map["url"]);
    }
    notifyListeners();
  }

  void toggleFavoriteImage(String catImage) {
    if (favoriteImages.contains(catImage)) {
      favoriteImages.remove(catImage); //이미 좋아요한 경우
    } else {
      favoriteImages.add(catImage); // 좋아요 이미지 추가
    }

    notifyListeners(); // consumer아래 builder부분 새로 시작해서 갱신
  }
}

/// 홈 페이지
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CatService>(
      builder: (context, catService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("랜덤 고양이"),
            backgroundColor: Colors.amber,
            actions: [
              // 좋아요 페이지로 이동
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritePage()),
                  );
                },
              ),
            ],
          ),
          // 고양이 사진 목록
          body: GridView.count(
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            padding: EdgeInsets.all(8),
            crossAxisCount: 2,
            children: List.generate(catService.catImages.length, (index) {
              // 반복 출력
              String catImage = catService.catImages[index];
              return GestureDetector(
                // 사진 클릭 시 이벤트
                onTap: () {
                  catService.toggleFavoriteImage(catImage);
                },
                child: Stack(
                  children: [
                    Positioned.fill(
                      // 모든 top left right를 0으로 간격을 주지 않고 채우겠다.
                      child: Image.network(catImage, fit: BoxFit.cover),
                    ),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: catService.favoriteImages.contains(catImage)
                          ? Icon(Icons.favorite, color: Colors.amber)
                          : Icon(
                              Icons.favorite_border,
                              color: Colors.amber,
                            ), // transparent는 투명색
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

/// 좋아요 페이지
class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CatService>(
      builder: (context, catService, child) {
        return Scaffold(
          appBar: AppBar(title: Text("좋아요"), backgroundColor: Colors.amber),
          body: GridView.count(
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            padding: EdgeInsets.all(8),
            crossAxisCount: 2,
            children: List.generate(catService.favoriteImages.length, (index) {
              // 반복 출력
              String catImage = catService.favoriteImages[index];
              return GestureDetector(
                // 사진 클릭 시 이벤트
                onTap: () {
                  catService.toggleFavoriteImage(catImage);
                },
                child: Stack(
                  children: [
                    Positioned.fill(
                      // 모든 top left right를 0으로 간격을 주지 않고 채우겠다.
                      child: Image.network(catImage, fit: BoxFit.cover),
                    ),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: catService.favoriteImages.contains(catImage)
                          ? Icon(Icons.favorite, color: Colors.amber)
                          : Icon(
                              Icons.favorite_border,
                              color: Colors.amber,
                            ), // transparent는 투명색
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
