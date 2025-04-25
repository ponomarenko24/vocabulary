import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary/word.dart';
import 'package:vocabulary/wordProvider.dart';
import 'package:vocabulary/vocabulary_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WordAdapter());
  await Hive.openBox<Word>('wordsBox');

  runApp(
    ChangeNotifierProvider(
      create: (_) => WordProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}