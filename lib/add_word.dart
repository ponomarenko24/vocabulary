import 'package:flutter/material.dart';

class AddWord extends StatefulWidget {
  const AddWord({super.key});

  @override
  State<AddWord> createState() => _AddWordState();
}

class _AddWordState extends State<AddWord> {
  final TextEditingController wordController = TextEditingController();
  final TextEditingController translationController = TextEditingController();

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    wordController.addListener(_checkFields);
    translationController.addListener(_checkFields);
  }

  @override
  void dispose() {
    super.dispose();
    wordController.dispose();
    translationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add new word')),
      body: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: wordController,
              decoration: const InputDecoration(
                labelText: 'Word',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 64),
            TextField(
              controller: translationController,
              decoration: const InputDecoration(
                labelText: 'Translate',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 64),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _cancel,
                  label: const Text('Cancel'),
                ),

                ElevatedButton.icon(
                  onPressed: isButtonEnabled ? _saveWord : null,
                  label: const Text('Save'),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>((
                      Set<WidgetState> states,
                    ) {
                      if (states.contains(WidgetState.disabled)) {
                        return Colors.grey;
                      }
                      return Colors.green;
                    }),
                    foregroundColor: WidgetStateProperty.resolveWith<Color>((
                      Set<WidgetState> states,
                    ) {
                      if (states.contains(WidgetState.disabled)) {
                        return Colors.black45;
                      }
                      return Colors.white;
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _checkFields() {
    final isFilled =
        wordController.text.trim().isNotEmpty &&
        translationController.text.trim().isNotEmpty;

    if (isFilled != isButtonEnabled) {
      setState(() {
        isButtonEnabled = isFilled;
      });
    }
  }

  void _saveWord() {
    String word = wordController.text.trim();
    String translation = translationController.text.trim();

    if (word.isNotEmpty && translation.isNotEmpty) {
      print('Збережено: $word — $translation');
  
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please, fill in both textfields')),
      );
    }
  }

  void _cancel() {
    Navigator.pop(context);
  }
}
