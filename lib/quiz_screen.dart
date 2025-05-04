import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary/wordProvider.dart';
import 'package:vocabulary/word.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Word> quizWords = [];
  int currentIndex = 0;
  int correctAnswers = 0;
  final TextEditingController answerController = TextEditingController();

@override void dispose() {
    super.dispose();
    answerController.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final wordProvider = Provider.of<WordProvider>(context, listen: false);
      setState(() {
        quizWords = wordProvider.words.take(11).toList();
      });
    });
  }

  void _nextWord() {
    if (currentIndex < quizWords.length) {
      final word = quizWords[currentIndex];

      if (answerController.text.trim().toLowerCase() == word.word.toLowerCase()) {
        correctAnswers++;
      }

      setState(() {
        currentIndex++;
        answerController.clear();
      });

      if (currentIndex == 10) {
        _showResults();
      }
    }
  }

  void _showResults() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Finished'),
        content: Text('You answered $correctAnswers out of 10 correctly!'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (quizWords.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: const Center(child: Text('No words available for the quiz.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Translate: ${quizWords[currentIndex].translation}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: answerController,
              decoration: const InputDecoration(
                labelText: 'Your Answer',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _nextWord,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
