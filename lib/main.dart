import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  void _showDialog(BuildContext context, bool useFirstVersion) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dialog'),
          content: const TextField(),
          actions: [
            ElevatedButton(
              child: const Text('Close'),
              onPressed: () {
                if (useFirstVersion) {
                  _unFocusFirstVersion();
                } else {
                  _unFocusSecondVersion(context);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _unFocusFirstVersion() {
    primaryFocus?.unfocus();
  }

  void _unFocusSecondVersion(BuildContext context) {
    final currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus Demo'),
      ),
      body: Center(
        child: Column(
          children: [
            const TextField(
              autofocus: true,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _showDialog(context, true),
              child: const Text('Open Dialog (条件なし)'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _showDialog(context, false),
              child: const Text('Open Dialog (条件あり)'),
            ),
          ],
        ),
      ),
    );
  }
}
