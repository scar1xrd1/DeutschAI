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
      appBar: AppBar(title: const Text('DeutschAI')),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Введите предложение', style: TextStyle(fontSize: 24)),

              const SizedBox(height: 20),

              TextField(
                controller: _controller,
                onChanged: onTextChanged,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Введите текст',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: onClearPressed,
                  ),
                ),
                style: TextStyle(fontSize: 18, color: Colors.blue),
              ),

              const SizedBox(height: 60),

              ElevatedButton(
                onPressed: _isButtonEnabled ? onButtonPressed : null,
                child: const Text('Отправить'),
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

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _result = _aiService.checkSentence(text);
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
