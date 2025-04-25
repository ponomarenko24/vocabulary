import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vocabulary/word.dart';

class WordProvider extends ChangeNotifier {
  final Box<Word> _box = Hive.box<Word>('wordsBox');

  List<Word> get words => _box.values.toList();

  void addWord(Word word) {
    _box.add(word);
    notifyListeners();
  }

  void removeWord(int index) {
    _box.deleteAt(index);
    notifyListeners();
  }

  void clearWords() {
    _box.clear();
    notifyListeners();
  }
}
