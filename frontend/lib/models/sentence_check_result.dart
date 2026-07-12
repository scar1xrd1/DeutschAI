class SentenceCheckResult {
  final String correctedText;
  final String tip;
  final List<String> errors;

  SentenceCheckResult({
    required this.correctedText,
    this.tip = "",
    this.errors = const [],
  });
}
