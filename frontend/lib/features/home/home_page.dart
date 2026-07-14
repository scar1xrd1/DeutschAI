import 'package:flutter/material.dart';
import 'package:frontend/services/ai_service.dart';
import 'package:frontend/models/sentence_check_result.dart';
import 'package:frontend/widgets/result_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  SentenceCheckResult?
  _result; // Переменная для хранения результата проверки предложения
  bool _isButtonEnabled = false; // Переключатель возможности нажатия кнопки
  bool _isLoading = false; // Переключатель состояния загрузки
  final AIService _aiService = AIService();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final result = _result;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 36, 42),

      appBar: AppBar(title: const Text('DeutschAI')),
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Gib einen Satz ein', style: TextStyle(fontSize: 24)),

              const SizedBox(height: 20),

              TextField(
                controller: _controller,
                onChanged: onTextChanged,

                textInputAction: TextInputAction.done,
                onSubmitted: (_) {
                  if (_isButtonEnabled) {
                    onButtonPressed();
                  }
                },

                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 54, 56, 64),

                  hintText: 'Satz eingeben', // hint text
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 176, 177, 182),
                  ),
                  floatingLabelStyle: const TextStyle(
                    color: Color.fromARGB(0, 93, 93, 93),
                  ),

                  suffixIcon: IconButton(
                    color: Color.fromARGB(255, 226, 228, 236),
                    icon: Icon(Icons.clear),
                    onPressed: onClearPressed,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 54, 56, 64),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 226, 228, 236),
                    ),
                  ),
                ),
                cursorColor: const Color.fromARGB(255, 226, 228, 236),
                style: TextStyle(
                  fontSize: 18,
                  color: const Color.fromARGB(255, 226, 228, 236),
                ),
              ),

              const SizedBox(height: 60),

              ElevatedButton(
                onPressed: _isButtonEnabled ? onButtonPressed : null,
                child: const Text('Satz prüfen'),
              ),

              const SizedBox(height: 20),

              _isLoading
                  ? const CircularProgressIndicator()
                  : result != null
                  ? ResultCard(result: result)
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onButtonPressed() async {
    final text = _controller.text.trim();
    _controller.clear();

    setState(() {
      _isLoading = true;
      _isButtonEnabled = false;
    });

    final result = await _aiService.checkSentence(text);

    setState(() {
      _isLoading = false;
      _result = result;
    });
  }

  void onTextChanged(String text) {
    setState(() {
      _isButtonEnabled = text.trim().isNotEmpty;
    });
  }

  void onClearPressed() {
    _controller.clear();
    setState(() {
      _isButtonEnabled = false;
    });
  }
}
