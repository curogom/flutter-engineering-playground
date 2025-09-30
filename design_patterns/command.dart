import 'dart:collection';
import 'package:flutter/material.dart';

// Command 인터페이스
abstract class Command {
  String get name;
  void execute();
  void undo();
}

// Drawing을 위한 구체적인 Command
class DrawCommand implements Command {
  DrawCommand();

  @override
  String get name => 'DrawCommand';

  @override
  void execute() {}

  @override
  void undo() {}
}

// ChangeColor를 위한 구체적인 Command
class ChangeColorCommand implements Command {
  ChangeColorCommand();

  @override
  String get name => 'ChangeColorCommand';

  @override
  void execute() {}

  @override
  void undo() {}
}

// 실행 및 되돌리기를 처리하는 Command Manager
class CommandManager {
  final _commandList = ListQueue<Command>();

  bool get hasHistory => commandHistoryList.isNotEmpty;

  List<String> get commandHistoryList =>
      _commandList.map((c) => c.name).toList();

  void executeCommand(Command command) => _commandList.add(command);

  void undo() {
    if (_commandList.isEmpty) return;
    _commandList.removeLast().undo();
  }
}

class MyApp extends StatefulWidget {
  final CommandManager commandManager;

  const MyApp({
    super.key,
    required this.commandManager,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Command Pattern Example'),
        ),
        body: Column(
          key: const Key('drawButtonKey'),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                widget.commandManager.executeCommand(
                  DrawCommand(),
                );
                setState(() {});
              },
              child: const Text('Tap to draw'),
            ),
            TextButton(
              onPressed: () {
                widget.commandManager.executeCommand(
                  ChangeColorCommand(),
                );
                setState(() {});
              },
              child: const Text('Tap to Change Color'),
            ),
            if (widget.commandManager.hasHistory)
              TextButton(
                onPressed: () {
                  widget.commandManager.undo();
                  setState(() {});
                },
                child: const Text('Press to undo'),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.commandManager.commandHistoryList.length,
                itemBuilder: (context, index) {
                  return Text(widget.commandManager.commandHistoryList[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

// 앱에서의 사용 예시
void main() {
  final CommandManager commandManager = CommandManager();

  runApp(
    MyApp(
      commandManager: commandManager,
    ),
  );
}
