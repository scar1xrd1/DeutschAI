import 'package:frontend/models/sentence_check_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AIService {
  Future<SentenceCheckResult> checkSentence(String sentence) async {
    final response = await http.post(
      Uri.parse("https://api.groq.com/openai/v1/chat/completions"),
      headers: {"Authorization": "Bearer ", "Content-Type": "application/json"},
      body: jsonEncode({
        "model": "llama-3.3-70b-versatile",
        "messages": [
          {
            "role": "system",
            "content": """
You are a German grammar teacher.

Always answer in German.

Always return ONLY valid JSON.

{
  "correctedText":"",
  "tip":"",
  "errors":[]
}
""",
          },
          {"role": "user", "content": sentence},
        ],
      }),
    );

    final data = jsonDecode(response.body);
    final content = data['choices'][0]['message']['content'];
    final aiResponse = jsonDecode(content);

    print(response.statusCode);
    print(response.body);

    return SentenceCheckResult(
      correctedText: aiResponse["correctedText"],
      tip: aiResponse["tip"],
      errors: List<String>.from(aiResponse["errors"]),
    );
  }
}
