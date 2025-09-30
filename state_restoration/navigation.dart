import 'package:flutter/material.dart';

void main() {
  runApp(
    const RootRestorationScope(
      restorationId: 'root',
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      restorationScopeId: 'app',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with RestorationMixin {
  @override
  String? get restorationId => 'home_screen';

  @override
  void restoreState(
      RestorationBucket? oldBucket, bool initialRestore) {
    // 필요한 경우 여기에서 상태를 복원합니다.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to Details'),
          onPressed: () => Navigator.of(context)
              .restorablePush(_detailsScreenRouteBuilder),
        ),
      ),
    );
  }

  static Route<dynamic> _detailsScreenRouteBuilder(
      BuildContext context, Object? arguments) {
    return MaterialPageRoute<void>(
      builder: (BuildContext context) =>
          const DetailsScreen(),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: const Center(
        child: Text('Details Screen'),
      ),
    );
  }
}
