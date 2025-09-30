import 'package:flutter/material.dart';

enum ScreenSize {
  // 세로 모드 폰
  compact(maxWidth: 600),
  // 세로 모드 태블릿 또는 세로 모드 폴더블(펼침)
  medium(maxWidth: 840),
  // 가로 모드 폰 또는 가로 모드 태블릿 또는
  // 가로 모드 폴더블(펼침) 또는 데스크톱
  expanded(maxWidth: 1200),
  // 데스크톱
  large(maxWidth: 1600);

  const ScreenSize({required this.maxWidth});

  final double maxWidth;

  bool isSmallerThan(double screenWidth) => screenWidth < maxWidth;
  bool isGreaterThan(double screenWidth) => screenWidth >= maxWidth;

  static ScreenSize getScreenSize(double screenWidth) {
    if (ScreenSize.compact.isSmallerThan(screenWidth)) {
      return ScreenSize.compact;
    } else if (ScreenSize.medium.isSmallerThan(screenWidth)) {
      return ScreenSize.medium;
    } else if (ScreenSize.expanded.isSmallerThan(screenWidth)) {
      return ScreenSize.expanded;
    } else {
      return ScreenSize.large;
    }
  }
}

main() {
  WidgetsBinding.instance.platformDispatcher.onAccessibilityFeaturesChanged =
      () {
    print('reduceMotion: ');
  };

  runApp(const MyResponsiveApp());
}

class MyResponsiveApp extends StatelessWidget {
  const MyResponsiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Layout with Strategies',
      home: ResponsiveLayout(
        compactLayoutStrategy: CompactLayoutStrategy(),
        mediumLayoutStrategy: MediumLayoutStrategy(),
        expandedLayoutStrategy: ExpandedLayoutStrategy(),
        largeLayoutStrategy: LargeLayoutStrategy(),
      ),
    );
  }
}

abstract class LayoutStrategy {
  Widget build(BuildContext context);
}

class CompactLayoutStrategy implements LayoutStrategy {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.orientationOf(context) == Orientation.portrait
        ? const Text('MobilePortraitLayout')
        : const Text('MobileLandscapeLayout');
  }
}

class MediumLayoutStrategy implements LayoutStrategy {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('MediumLayoutStrategy'),
    );
  }
}

class ExpandedLayoutStrategy implements LayoutStrategy {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('ExpandedLayoutStrategy'),
    );
  }
}

class LargeLayoutStrategy implements LayoutStrategy {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('LargeLayoutStrategy'),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  final LayoutStrategy compactLayoutStrategy;
  final LayoutStrategy mediumLayoutStrategy;
  final LayoutStrategy expandedLayoutStrategy;
  final LayoutStrategy largeLayoutStrategy;

  const ResponsiveLayout({
    super.key,
    required this.compactLayoutStrategy,
    required this.mediumLayoutStrategy,
    required this.expandedLayoutStrategy,
    required this.largeLayoutStrategy,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final layoutStrategy = _getLayoutStrategy(constraints.maxWidth);
        return layoutStrategy.build(context);
      },
    );
  }

  LayoutStrategy _getLayoutStrategy(double width) {
    final screenSize = ScreenSize.getScreenSize(width);

    switch (screenSize) {
      case ScreenSize.compact:
        return compactLayoutStrategy;
      case ScreenSize.medium:
        return mediumLayoutStrategy;
      case ScreenSize.expanded:
        return expandedLayoutStrategy;
      case ScreenSize.large:
        return largeLayoutStrategy;
    }
  }
}

class MyCustomLayout extends StatelessWidget {
  const MyCustomLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildLayout(
      delegate: MyCustomDelegate(),
      child: Container(color: Colors.blue),
    );
  }
}

class MyCustomDelegate extends SingleChildLayoutDelegate {
  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // 자식의 커스텀 제약 조건
    return constraints;
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // 자식을 오른쪽 하단 모서리에 배치
    return Offset(size.width - childSize.width, size.height - childSize.height);
  }

  @override
  bool shouldRelayout(MyCustomDelegate oldDelegate) => false;
}

class MySingleChildLayoutDelegate extends SingleChildLayoutDelegate {
  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // 부모의 제약 조건을 기반으로 자식의 제약 조건 수정
    return BoxConstraints.tight(const Size(100, 100));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // 자식을 부모의 중앙에 배치
    return Offset(size.width / 2 - childSize.width / 2,
        size.height / 2 - childSize.height / 2);
  }

  @override
  bool shouldRelayout(MySingleChildLayoutDelegate oldDelegate) => false;
}

class MyComplexLayout extends StatelessWidget {
  const MyComplexLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: MyComplexLayoutDelegate(),
      children: <Widget>[
        LayoutId(
          id: 'first',
          child: Container(color: Colors.red, width: 100, height: 100),
        ),
        LayoutId(
          id: 'second',
          child: Container(color: Colors.green, width: 100, height: 100),
        ),
      ],
    );
  }
}

class MyComplexLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    // 'first' 위젯 위치 지정
    layoutChild('first', BoxConstraints.loose(size));
    positionChild('first', Offset.zero);

    // 'second' 위젯을 'first'의 오른쪽에 위치 지정
    if (hasChild('second')) {
      Size firstSize = layoutChild('first', BoxConstraints.loose(size));
      layoutChild('second', BoxConstraints.loose(size));
      positionChild('second', Offset(firstSize.width, 0));
    }
  }

  @override
  bool shouldRelayout(MyComplexLayoutDelegate oldDelegate) => false;
}

class ResponsiveChips extends StatelessWidget {
  final List<String> options;

  const ResponsiveChips({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      direction: Axis.horizontal,
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 4.0, // gap between lines
      children: options.map((option) => Chip(label: Text(option))).toList(),
    );
  }
}

class GalleryApp extends StatelessWidget {
  const GalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: OrientationBuilder(
          builder: (context, orientation) {
            return GridView.count(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              children: List.generate(20, (index) {
                return Center(
                  child: Text(
                    'Item $index',
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
