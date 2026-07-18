import 'package:flutter/material.dart';
import 'package:frontend/models/sentence_check_result.dart';

class ResultCard extends StatelessWidget {
  final SentenceCheckResult result;

  const ResultCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: const Color.fromARGB(255, 44, 46, 53),
      margin: const EdgeInsets.only(top: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "✅ Correct sentence",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              result.correctedSentence,
              style: const TextStyle(fontSize: 22, color: Colors.white),
            ),

            const SizedBox(height: 20),

            if (result.mistakes.isNotEmpty) ...[
              const Text(
                "❌ Mistakes",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 8),

              ...result.mistakes.map(
                (mistake) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    "• $mistake",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 220, 80, 80),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],

            if (result.grammarRule.isNotEmpty) ...[
              const Text(
                "📚 Grammar rule",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                result.grammarRule,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.lightBlueAccent,
                ),
              ),

              const SizedBox(height: 20),
            ],

            if (result.tip.isNotEmpty) ...[
              const Text(
                "💡 Tip",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                result.tip,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.orangeAccent,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
