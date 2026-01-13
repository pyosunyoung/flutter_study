import 'package:diary/diary_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 달력 보여주는 형식
  CalendarFormat calendarFormat = CalendarFormat.month;

  // 선택된 날짜
  DateTime selectedDate = DateTime.now();

  // create text controller
  TextEditingController createTextController = TextEditingController();

  // update text controller
  TextEditingController updateTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<DiaryService>(
      builder: (context, diaryService, child) {
        // List<Diary> diaryList = diaryService.diaryList;
        List<Diary> diaryList = diaryService.getByDate(selectedDate); //오류 해결
        return Scaffold(
          // 키보드가 올라올 때 화면 밀지 않도록 만들기(overflow 방지)
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Column(
              children: [
                TableCalendar(
                  focusedDay: selectedDate,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  calendarFormat: calendarFormat, //아래랑 짝궁
                  onFormatChanged: (format) {
                    // 달력 형식 변경
                    setState(() {
                      calendarFormat = format;
                    });
                  },
                  selectedDayPredicate: (day) {
                    // 이게 있어야 탭한 날짜 선택 날짜 표시, 가로 스와이프하여 월 변경 기능 가능

                    return isSameDay(selectedDate, day);
                  },
                  eventLoader: (date) {
                    return diaryService.getByDate(date);
                  },
                  calendarStyle: CalendarStyle(
                    // today 색상 제거
                    todayTextStyle: TextStyle(color: Colors.black),
                    todayDecoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  onDaySelected: (_, focusedDay) { // 해당 선택 날짜 값이 들어감
                    // 날짜 선택
                    setState(() {
                      selectedDate = focusedDay;
                      // _focusedDay = focusedDay; // update `_focusedDay` here as well\
                    });
                  },
                ),
                Divider(height: 1),
                Expanded(
                  child: diaryList.isEmpty
                      ? Center(
                          child: Text(
                            "한 줄 일기를 작성해주세요.",
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                        )
                      : ListView.separated(
                          itemCount: diaryList.length,
                          itemBuilder: (context, index) {
                            int i = diaryList.length - index - 1;
                            Diary diary = diaryList[i];
                            return ListTile(
                              /// text
                              title: Text(
                                diary.text,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                ),
                              ),

                              /// createdAt
                              trailing: Text(
                                DateFormat('kk:mm').format(diary.createdAt),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),

                              /// 클릭하여 update
                              onTap: () {
                                showUpdateDialog(diaryService, diary);
                              },

                              /// 꾹 누르면 delete
                              onLongPress: () {
                                showDeleteDialog(diaryService, diary);
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            // item 사이에 Divider 추가
                            return Divider(height: 1);
                          },
                        ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.create, color: Colors.white),
            backgroundColor: Colors.indigo,
            onPressed: () {
              showCreateDialog(diaryService);
            },
          ),
        );
      },
    );
  }

  /// 작성하기
  /// 엔터를 누르거나 작성 버튼을 누르는 경우 호출
  void createDiary(DiaryService diaryService) {
    String newText = createTextController.text.trim();
    if (newText.isNotEmpty) {
      // isEmpty 값이 비어 있을 때 <=> isNotEmpty 값이 존재 할 때
      diaryService.create(newText, selectedDate); // 그떄 해당 text 입력값을 넘겨주어라.
      createTextController.text = "";
    }
  }

  /// 수정하기
  /// 엔터를 누르거나 수정 버튼을 누르는 경우 호출
  void updateDiary(DiaryService diaryService, Diary diary) {
    // 앞뒤 공백 삭제
    String updatedText = updateTextController.text.trim();
    if (updatedText.isNotEmpty) {
      diaryService.update(
        diary.createdAt, //
        updatedText,
      );
    }
  }

  void showCreateDialog(DiaryService diaryService) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("일기 작성"),
          content: TextField(
            controller: createTextController,
            autofocus: true,
            cursorColor: Colors.indigo,
            decoration: InputDecoration(
              hintText: "한 줄 일기를 작성해주세요.",

              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo),
              ),
            ),
            onSubmitted: (_) {
              // 엔터 누를 때 작성하기
              createDiary(diaryService);
              Navigator.pop(context);
            },
          ),

          actions: [
            /// 취소 버튼
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("취소", style: TextStyle(color: Colors.indigo)),
            ),

            /// 작성 버튼
            TextButton(
              onPressed: () {
                createDiary(diaryService);
                Navigator.pop(context);
              },
              child: Text("작성", style: TextStyle(color: Colors.indigo)),
            ),
          ],
        );
      },
    );
  }

  void showUpdateDialog(DiaryService diaryService, Diary diary) {
    showDialog(
      context: context,
      builder: (context) {
        updateTextController.text = diary.text; //해당
        return AlertDialog(
          title: Text("일기 수정"),
          content: TextField(
            controller: updateTextController,
            cursorColor: Colors.indigo,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo),
              ),
            ),
            onSubmitted: (_) {
              // 엔터 누를 때 작성하기
              updateDiary(diaryService, diary);
              Navigator.pop(context);
            },
          ),

          actions: [
            /// 취소 버튼
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("취소", style: TextStyle(color: Colors.indigo)),
            ),

            /// 수정 버튼
            TextButton(
              onPressed: () {
                updateDiary(diaryService, diary);
                Navigator.pop(context);
              },
              child: Text("수정", style: TextStyle(color: Colors.indigo)),
            ),
          ],
        );
      },
    );
  }

  void showDeleteDialog(DiaryService diaryService, Diary diary) {
    showDialog(
      context: context,
      builder: (context) {
        updateTextController.text = diary.text; // 없어도 됨.
        return AlertDialog(
          title: Text("일기 삭제"),
          content: Text("${diary.text}을 삭제하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "취소",
                style: TextStyle(fontSize: 18, color: Colors.indigo),
              ),
            ),
            TextButton(
              child: Text(
                "삭제",
                style: TextStyle(fontSize: 18, color: Colors.indigo),
              ),
              onPressed: () {
                diaryService.delete(diary.createdAt);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
