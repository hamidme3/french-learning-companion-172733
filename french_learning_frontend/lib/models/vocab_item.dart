/// Model definition for vocabulary items in the app.
class VocabItem {
  final String id;
  final String french;
  final String english;
  final String category;
  final String? exampleSentence;

  VocabItem({
    required this.id,
    required this.french,
    required this.english,
    required this.category,
    this.exampleSentence,
  });
}
