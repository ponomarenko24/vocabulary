import 'package:flutter/material.dart';
import 'package:vocabulary/add_word.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('My vocabulary')),
        body: const Center(child: Text('Hello World!')),
        floatingActionButton: floatingButtonAdd(),
      ),
    );
  }

  Builder floatingButtonAdd() {
    return Builder(
      builder: (context) {
        return FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddWord()),
            );
          },
          child: const Icon(Icons.add),
        );
      },
    );
  }
}
