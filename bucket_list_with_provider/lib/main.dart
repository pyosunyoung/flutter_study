import 'package:bucket_list_with_provider/bucket_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      //MultiProvider는 위젯트리 꼭대기에 여러 서비스들을 등록할 수 있도록 만들 때 사용합니다. //어디서든 접근 가능 Redux 느낌?
      providers: [ChangeNotifierProvider(create: (context) => BucketService())],
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

/// 버킷 클래스
class Bucket {
  String job; // 할 일
  bool isDone; // 완료 여부

  Bucket(this.job, this.isDone); // 생성자
}

// BucketService에 있는 bucketList 값을 가져와서 HomePage에 보여줘야 합니다.
// Consumer 위젯을 이용하면 위젯트리 꼭대기에 등록된 BucketService에 접근할 수 있습니다.
/// 홈 페이지
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // - `Consumer<BucketService>` : 위젯트리 상단에서 찾아올 클래스 이름을 `<>`사이에 적습니다.
    // - `builder: (context, bucketService, child) { return 위젯; }` : 화면에 보여줄 위젯을 반환하는 함수로, 위젯트리 상단에서 찾아온 클래스를 두 번째 파라미터로 받을 수 있습니다.
    return Consumer<BucketService>(
      builder: (context, bucketService, child) {
        // bucketService로 부터 bucketList 가져오기
        List<Bucket> bucketList = bucketService.bucketList;
        return Scaffold(
          appBar: AppBar(title: Text("버킷 리스트")),
          body: bucketList.isEmpty
              ? Center(child: Text("버킷 리스트를 작성해 주세요."))
              : ListView.builder(
                  itemCount: bucketList.length, // bucketList 개수 만큼 보여주기
                  itemBuilder: (context, index) {
                    var bucket = bucketList[index]; // index에 해당하는 bucket 가져오기
                    return ListTile(
                      // 버킷 리스트 할 일
                      title: Text(
                        bucket.job,
                        style: TextStyle(
                          fontSize: 24,
                          color: bucket.isDone ? Colors.grey : Colors.black,
                          decoration: bucket.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      // 삭제 아이콘 버튼
                      trailing: IconButton(
                        icon: Icon(CupertinoIcons.delete),
                        onPressed: () {
                          // 삭제 버튼 클릭시

                          bucketService.deleteBucket(index);
                        },
                      ),
                      onTap: () {
                        // 아이템 클릭시

                        bucket.isDone = !bucket.isDone; // 클릭 여부
                        bucketService.updateBucket(
                          bucket,
                          index,
                        ); // bucket은 해당 선택한 index 아이템
                      },
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              // + 버튼 클릭시 버킷 생성 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CreatePage()),
              );
            },
          ),
        );
      },
    );
  }
}

/// 버킷 생성 페이지
class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  // TextField의 값을 가져올 때 사용합니다.
  TextEditingController textController = TextEditingController();

  // 경고 메세지
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("버킷리스트 작성"),
        // 뒤로가기 버튼
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 텍스트 입력창
            TextField(
              controller: textController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "하고 싶은 일을 입력하세요",
                errorText: error,
              ),
            ),
            SizedBox(height: 32),
            // 추가하기 버튼
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                child: Text("추가하기", style: TextStyle(fontSize: 18)),
                onPressed: () {
                  // 추가하기 버튼 클릭시
                  String job = textController.text;
                  if (job.isEmpty) {
                    setState(() {
                      error = "내용을 입력해주세요."; // 내용이 없는 경우 에러 메세지
                    });
                  } else {
                    setState(() {
                      error = null; // 내용이 있는 경우 에러 메세지 숨기기
                    });

                    // BucketService 가져오기
                    //context.read<클래스명>();를 이용하면 위젯 트리 상단에 있는 Provider로 등록한 클래스에 접근할 수 있습니다.
                    BucketService bucketService = context.read<BucketService>();
                    bucketService.createBucket(job);
                    Navigator.pop(context); // 화면을 종료합니다.
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
