import 'package:flutter/material.dart';
import 'package:frontend/services/ai_service.dart';
import 'package:frontend/models/sentence_check_result.dart';
import 'package:frontend/widgets/result_card.dart';
import 'package:frontend/widgets/send_button.dart';
import 'package:frontend/theme/app_colors.dart';

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
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('DeutschAI')),
      body: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controller,
                onChanged: onTextChanged,

                minLines: 1,
                maxLines: 8,

                textInputAction: TextInputAction.done,
                onSubmitted: (_) {
                  if (_isButtonEnabled) {
                    onButtonPressed();
                  }
                },

                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.surfaceLight,

                  hintText: 'Gib einen Satz ein', // hint text
                  hintStyle: const TextStyle(color: AppColors.hint),
                  floatingLabelStyle: const TextStyle(
                    color: AppColors.textSecondary,
                  ),

                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SendButton(
                      enabled: _isButtonEnabled,
                      loading: _isLoading,
                      onPressed: onButtonPressed,
                      onLongPressed: onClearPressed,
                    ),
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28.0),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28.0),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
                cursorColor: AppColors.primary,
                style: TextStyle(fontSize: 18, color: AppColors.textPrimary),
              ),

              const SizedBox(height: 60),

              // ElevatedButton(
              //   onPressed: _isButtonEnabled ? onButtonPressed : null,
              //   child: const Text('Satz prüfen'),
              // ),
              const SizedBox(height: 20),

              _isLoading
                  ? const SizedBox.shrink()
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
