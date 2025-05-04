import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulary/add_word_screen.dart';
import 'package:vocabulary/quiz_screen.dart';
import 'package:vocabulary/wordProvider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Vocabulary')),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Consumer<WordProvider>(
                  builder: (context, wordProvider, child) {
                    final words = wordProvider.words;

                    if (words.isEmpty) {
                      return const Center(child: Text('No words yet.'));
                    }

                    return ListView.separated(
                      itemCount: words.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final word = words[index];
                        return ListTile(
                          title: Text(word.word),
                          subtitle: Text(word.translation),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              wordProvider.removeWord(index);
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ElevatedButton(
                onPressed: () {
Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QuizScreen()),
    );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 56),
                  elevation: 6,
                  shadowColor: Colors.black,
                ),
                child: const Text('Start quiz'),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddWordScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
