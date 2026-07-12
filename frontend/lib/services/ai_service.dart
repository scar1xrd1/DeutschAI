import 'package:frontend/models/sentence_check_result.dart';

class AIService {
  SentenceCheckResult checkSentence(String sentence) {
    if (sentence.toLowerCase() == "ich gehe schule") {
      return SentenceCheckResult(
        correctedText: "Ich gehe zur Schule.",
        tip:
            "You need to add 'zur' before 'Schule' to make the sentence grammatically correct.",
        errors: ["The preposition \"zur\" is missing."],
      );
    }
    return SentenceCheckResult(correctedText: sentence);
  }
}
