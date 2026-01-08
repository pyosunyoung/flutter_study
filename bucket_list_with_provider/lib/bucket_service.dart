import 'package:flutter/material.dart';

import 'main.dart';

/// Bucket 담당
class BucketService extends ChangeNotifier {
  // ChangeNotifier를 상속 받은 경우 notifylisteners();를 호출하여 위젯들을 갱신하는 기능을 사용할 수 있습니다.
  List<Bucket> bucketList = [
    Bucket('잠자기', false), // 더미(dummy) 데이터
  ];

  /// bucket 추가
  void createBucket(String job) {
    bucketList.add(Bucket(job, false));
    notifyListeners(); // 변경 사항이 있는 경우 => 갱신 = Consumer<BucketService>의 builder 부분만 새로고침
    //notifyListenrs는 ChangeNotifier에서 가져온 것
  }

  
	/// bucket 수정
  void updateBucket(Bucket bucket, int index) {
    bucketList[index] = bucket;
    notifyListeners();
  }

  	

	/// bucket 삭제
  void deleteBucket(int index) {
    bucketList.removeAt(index);
    notifyListeners();
  }
}

