import 'package:hive/hive.dart';

part 'word.g.dart';

@HiveType(typeId: 0)
class Word {
  @HiveField(0)
  final String word;

  @HiveField(1)
  final String translation;

  @HiveField(2)
  final int rank = 0;

  Word({required this.word, required this.translation});
}