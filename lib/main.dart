import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false /* debug 테그 삭제 */,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // 5초마다 페이지를 넘기는 타이머 설정
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      int nextPage = (_pageController.page?.toInt() ?? 0) + 1;
      if (nextPage == 9) {
        nextPage = 0; // 마지막 이미지가 끝나면 첫 이미지로 돌아갑니다.
      }
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Row(
              /* 상단 바 */
              children: [
                Icon(
                  CupertinoIcons.chevron_back,
                  size: 30,
                )
              ],
            ),
            /* 우츤 상단 아이콘*/
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.search,
                  size: 30,
                ),
              ),
              SizedBox(width: 16)
            ],
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 300,
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal /* 가로로 스크롤 가능*/,
                itemCount: 9 /* 빌드할 자식 위젯을 30개로*/,
                itemBuilder: (context, index) /* 콜백 함수, 각 index에 자식 위젯 빌드 */ {
                  return Container /* 각 index에 높이 50, 색상 파란색 Container 반환 */ (
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Image.asset(
                      'assets/0${index + 1}.jpg',
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 16.0),
              child: Text(
                "인기 크리에이터",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal /* 가로로 스크롤 가능*/,
                itemCount: 9 /* 빌드할 자식 위젯을 30개로*/,
                itemBuilder: (context, index) /* 콜백 함수, 각 index에 자식 위젯 빌드 */ {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child:
                          Container /* 각 index에 높이 50, 색상 파란색 Container 반환 */ (
                        width: 60,
                        child: Image.asset(
                          'assets/0${index + 1}.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
