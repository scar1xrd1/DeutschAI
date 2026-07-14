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
          children: [
            Text(
              result.correctedText,
              style: const TextStyle(fontSize: 22, color: Colors.white),
            ),

            const SizedBox(height: 12),

            if (result.tip.isNotEmpty)
              Text(
                result.tip,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 227, 136, 0),
                ),
              ),

            const SizedBox(height: 12),

            if (result.errors.isNotEmpty)
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: result.errors
                      .map(
                        (error) => Text(
                          error,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 186, 12, 0),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
