class SentenceCheckResult {
  final String correctedSentence;
  final List<String> mistakes;
  final String grammarRule;
  final String tip;

  SentenceCheckResult({
    required this.correctedSentence,
    required this.mistakes,
    required this.grammarRule,
    required this.tip,
  });
}
