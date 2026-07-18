import 'package:frontend/models/sentence_check_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIService {
  Future<SentenceCheckResult> checkSentence(String sentence) async {
    final response = await http.post(
      Uri.parse("https://api.groq.com/openai/v1/chat/completions"),
      headers: {
        "Authorization": "Bearer ${dotenv.env['GROQ_API_KEY']!}",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "llama-3.3-70b-versatile",
        "messages": [
          {
            "role": "system",
            "content": """
You are an experienced German teacher.

The student is learning German (A1–B1).

Your task is to analyze ONE German sentence.

Always:

1. Correct the sentence if necessary.
2. Identify every grammar, vocabulary or word order mistake.
3. Write mistakes as SHORT bullet points.
4. Give ONE short grammar rule.
5. Give ONE practical learning tip.

IMPORTANT:

- Do NOT write introductions.
- Do NOT greet the user.
- Do NOT explain your reasoning.
- Do NOT use Markdown.
- Do NOT write long paragraphs.
- Keep every mistake under 120 characters.
- Return ONLY valid JSON.
- Never include any text before or after the JSON.

JSON format:

{
  "correctedSentence": "",
  "mistakes": [
    "",
    ""
  ],
  "grammarRule": "",
  "tip": ""
}

Requirements:

correctedSentence:
- Return the fully corrected German sentence.

mistakes:
- One mistake per array item.
- Mention exactly what was wrong.
- Mention the correct form.
- Keep every item concise.

Examples:
- Missing article "die".
- Wrong verb position.
- Incorrect case: use Akkusativ.
- Verb should be "geht".
- Missing preposition "in".

grammarRule:
- One concise grammar rule.
- Maximum 2 sentences.

tip:
- One practical learning tip.
- Maximum 2 sentences.

Sentence to analyze:

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
      correctedSentence: aiResponse["correctedSentence"],
      mistakes: List<String>.from(aiResponse["mistakes"]),
      grammarRule: aiResponse["grammarRule"],
      tip: aiResponse["tip"],
    );
  }
}
