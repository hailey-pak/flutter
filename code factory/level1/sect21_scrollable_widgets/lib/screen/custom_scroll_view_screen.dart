import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';

class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _SliverFixedHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  // 최대 높이
  @override
  double get maxExtent => maxHeight;

  // 최소 높이
  @override
  double get minExtent => minHeight;

  @override
  // covariant - 상속된 클래스도 사용가능
  // oldDelegate - build가 실행됐을 때 이전 delegate
  // this - 새로운 delegate
  // shouldRebuild - 새로 build를 해야할지 말지 결정
  bool shouldRebuild(_SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  CustomScrollViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          renderSliverAppbar(),
          renderHeader(),
          renderSliverListBuilder(),
          renderHeader(),
          renderSliverListBuilder(),
          renderHeader(),
          renderSliverListBuilder(),
          renderHeader(),
          renderSliverListBuilder(),
          renderHeader(),
        ],
      ),
    );
  }

  SliverPersistentHeader renderHeader() {
    return SliverPersistentHeader(
      pinned: true,
        delegate: _SliverFixedHeaderDelegate(
            child: Container(
              color: Colors.black,
              child: const Center(
                child: Text(
                  '신기하지~',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            minHeight: 75,
            maxHeight: 150));
  }

  // AppBar
  SliverAppBar renderSliverAppbar() {
    return SliverAppBar(
      // 스크롤 했을 때 리스트의 중간에서도 AppBar가 내려오게 할 수 있음.
      floating: true,
      // 완전 고정
      pinned: false,
      // 자석 효과 floating true일 때만 사용가능
      snap: true,
      // 맨 위에서 한계 이상으로 스크롤 했을 때 남는 공간을 차지
      stretch: true,
      expandedHeight: 200,
      collapsedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'asset/img/image_1.jpeg',
          fit: BoxFit.cover,
        ),
        title: const Text('FlexibleSpace'),
      ),
      title: const Text('CustomScrollViewScreen'),
    );
  }

  // ListView 기본 생성자와 유사
  SliverList renderSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        numbers
            .map((e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length], index: e))
            .toList(),
      ),
    );
  }

  // ListView.builder 생성자와 유사
  SliverList renderSliverListBuilder() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        childCount: 100,
      ),
    );
  }

  // GridView.count 와 유사
  SliverGrid renderSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(
        numbers
            .map((e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length], index: e))
            .toList(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }

  // GridView.build 와 유사
  SliverGrid renderSliverGridBuilder() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      }, childCount: 100),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
      ),
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);

    return Container(
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
