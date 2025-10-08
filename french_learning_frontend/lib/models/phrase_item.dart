/// Model definition for phrasebook items in the app.
class PhraseItem {
  final String id;
  final String french;
  final String english;
  final String context;

  PhraseItem({
    required this.id,
    required this.french,
    required this.english,
    required this.context,
  });
}
