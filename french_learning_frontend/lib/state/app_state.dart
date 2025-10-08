import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/vocab_item.dart';
import '../models/phrase_item.dart';

/// Central application state using ChangeNotifier to manage vocabulary,
/// phrases, user favorites/learned, and quiz functionality.
class AppState extends ChangeNotifier {
  AppState() {
    // Ensure quiz questions are available synchronously for initial builds/tests.
    _generateQuiz();
    _init();
  }

  // Sample data
  final List<VocabItem> vocabulary = [
    // Basics
    VocabItem(id: 'v1', french: 'Bonjour', english: 'Hello', category: 'Basics', exampleSentence: 'Bonjour, comment ça va ?'),
    VocabItem(id: 'v2', french: 'Merci', english: 'Thank you', category: 'Basics', exampleSentence: 'Merci beaucoup !'),
    VocabItem(id: 'v3', french: 'S’il vous plaît', english: 'Please', category: 'Basics'),
    VocabItem(id: 'v4', french: 'Au revoir', english: 'Goodbye', category: 'Basics'),
    // Food
    VocabItem(id: 'v5', french: 'Pomme', english: 'Apple', category: 'Food'),
    VocabItem(id: 'v6', french: 'Pain', english: 'Bread', category: 'Food'),
    VocabItem(id: 'v7', french: 'Fromage', english: 'Cheese', category: 'Food'),
    // Colors
    VocabItem(id: 'v8', french: 'Rouge', english: 'Red', category: 'Colors'),
    VocabItem(id: 'v9', french: 'Bleu', english: 'Blue', category: 'Colors'),
    VocabItem(id: 'v10', french: 'Vert', english: 'Green', category: 'Colors'),
    // Animals
    VocabItem(id: 'v11', french: 'Chat', english: 'Cat', category: 'Animals'),
    VocabItem(id: 'v12', french: 'Chien', english: 'Dog', category: 'Animals'),
    // Verbs
    VocabItem(id: 'v13', french: 'Aller', english: 'To go', category: 'Verbs'),
    VocabItem(id: 'v14', french: 'Être', english: 'To be', category: 'Verbs'),
    VocabItem(id: 'v15', french: 'Avoir', english: 'To have', category: 'Verbs'),
    VocabItem(id: 'v16', french: 'Faire', english: 'To do/make', category: 'Verbs'),
    VocabItem(id: 'v17', french: 'Manger', english: 'To eat', category: 'Verbs'),
    VocabItem(id: 'v18', french: 'Boire', english: 'To drink', category: 'Verbs'),
  ];

  final List<PhraseItem> phrases = [
    PhraseItem(id: 'p1', french: 'Bonjour!', english: 'Hello!', context: 'Greeting'),
    PhraseItem(id: 'p2', french: 'Comment ça va ?', english: 'How are you?', context: 'Greeting'),
    PhraseItem(id: 'p3', french: 'Je m’appelle...', english: 'My name is...', context: 'Greeting'),
    PhraseItem(id: 'p4', french: 'Où sont les toilettes ?', english: 'Where is the restroom?', context: 'Travel'),
    PhraseItem(id: 'p5', french: 'Combien ça coûte ?', english: 'How much does it cost?', context: 'Travel'),
    PhraseItem(id: 'p6', french: 'Je voudrais une table pour deux.', english: 'I would like a table for two.', context: 'Dining'),
    PhraseItem(id: 'p7', french: 'L’addition, s’il vous plaît.', english: 'The bill, please.', context: 'Dining'),
    PhraseItem(id: 'p8', french: 'Je ne comprends pas.', english: 'I do not understand.', context: 'General'),
    PhraseItem(id: 'p9', french: 'Pouvez-vous répéter ?', english: 'Can you repeat?', context: 'General'),
    PhraseItem(id: 'p10', french: 'Parlez-vous anglais ?', english: 'Do you speak English?', context: 'Travel'),
    PhraseItem(id: 'p11', french: 'Merci beaucoup.', english: 'Thank you very much.', context: 'Courtesy'),
    PhraseItem(id: 'p12', french: 'Excusez-moi.', english: 'Excuse me.', context: 'Courtesy'),
  ];

  final Set<String> favorites = <String>{};
  final Set<String> learned = <String>{};

  // Quiz state
  int _quizIndex = 0;
  int _quizScore = 0;
  // Initialize as empty to avoid LateInitializationError; will be populated by _generateQuiz().
  List<_QuizQuestion> _quizQuestions = [];
  bool _quizAnswered = false;
  String? _lastSelectedOption;

  // Preferences keys
  static const String _kFavoritesKey = 'favorites';
  static const String _kLearnedKey = 'learned';

  SharedPreferences? _prefs;

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    final favs = _prefs?.getStringList(_kFavoritesKey) ?? <String>[];
    final learns = _prefs?.getStringList(_kLearnedKey) ?? <String>[];
    favorites.addAll(favs);
    learned.addAll(learns);
    _generateQuiz();
    notifyListeners();
  }

  Future<void> _save() async {
    await _prefs?.setStringList(_kFavoritesKey, favorites.toList());
    await _prefs?.setStringList(_kLearnedKey, learned.toList());
  }

  // PUBLIC_INTERFACE
  void toggleFavorite(String id) {
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }
    _save();
    notifyListeners();
  }

  // PUBLIC_INTERFACE
  void toggleLearned(String id) {
    if (learned.contains(id)) {
      learned.remove(id);
    } else {
      learned.add(id);
    }
    _save();
    notifyListeners();
  }

  // Quiz API
  int get quizIndex => _quizIndex;
  int get quizScore => _quizScore;
  bool get quizAnswered => _quizAnswered;
  String? get lastSelectedOption => _lastSelectedOption;

  // PUBLIC_INTERFACE
  /// Public read-only view of quiz questions to avoid exposing private types.
  List<QuizQuestionView> get quizQuestions =>
      _quizQuestions.map((q) => QuizQuestionView.fromInternal(q)).toList(growable: false);

  // PUBLIC_INTERFACE
  void restartQuiz() {
    _quizIndex = 0;
    _quizScore = 0;
    _quizAnswered = false;
    _lastSelectedOption = null;
    _generateQuiz();
    notifyListeners();
  }

  // PUBLIC_INTERFACE
  void answer(String option) {
    if (_quizAnswered) return;
    _quizAnswered = true;
    _lastSelectedOption = option;
    // Compare against the current question's correct answer without exposing private types.
    if (currentQuestion.correct == option) {
      _quizScore++;
    }
    notifyListeners();
  }

  // PUBLIC_INTERFACE
  void nextQuestion() {
    if (_quizIndex < _quizQuestions.length - 1) {
      _quizIndex++;
      _quizAnswered = false;
      _lastSelectedOption = null;
      notifyListeners();
    }
  }

  QuizQuestionView get currentQuestion {
    // Guard: if quiz list is empty, generate a minimal placeholder to avoid crashes.
    // UI layer also guards for empty list and shows a loader, so this is a fallback.
    if (_quizQuestions.isEmpty) {
      // Create a deterministic single-question placeholder
      final placeholder = _QuizQuestion(
        prompt: 'Loading quiz…',
        correct: '…',
        options: const ['…'],
        enToFr: true,
        base: vocabulary.first,
      );
      return QuizQuestionView.fromInternal(placeholder);
    }
    return QuizQuestionView.fromInternal(_quizQuestions[_quizIndex]);
  }

  void _generateQuiz() {
    // Multiple-choice 10 questions: either EN->FR or FR->EN with 3 distractors
    final rnd = Random();
    final pool = List<VocabItem>.from(vocabulary);
    pool.shuffle(rnd);

    final List<_QuizQuestion> qs = [];
    final takeCount = min(10, pool.length);
    for (var i = 0; i < takeCount; i++) {
      final item = pool[i];
      final isEnToFr = rnd.nextBool();
      final correct = isEnToFr ? item.french : item.english;

      // distractors
      final distractorPool = List<VocabItem>.from(vocabulary.where((v) => v.id != item.id));
      distractorPool.shuffle(rnd);
      final distractors = distractorPool.take(3).map((d) => isEnToFr ? d.french : d.english).toList();

      final options = List<String>.from(distractors)..add(correct);
      options.shuffle(rnd);

      final prompt = isEnToFr
          ? 'Translate to French: "${item.english}"'
          : 'Translate to English: "${item.french}"';

      qs.add(_QuizQuestion(
        prompt: prompt,
        correct: correct,
        options: options,
        enToFr: isEnToFr,
        base: item,
      ));
    }

    _quizQuestions = qs;
  }
}

/// Internal quiz question representation.
class _QuizQuestion {
  final String prompt;
  final String correct;
  final List<String> options;
  final bool enToFr;
  final VocabItem base;

  _QuizQuestion({
    required this.prompt,
    required this.correct,
    required this.options,
    required this.enToFr,
    required this.base,
  });

  bool isCorrect(String selection) => selection == correct;
}

/// PUBLIC_INTERFACE
class QuizQuestionView {
  /// Public view of a quiz question to avoid exposing private types.
  final String prompt;
  final String correct;
  final List<String> options;

  QuizQuestionView({
    required this.prompt,
    required this.correct,
    required this.options,
  });

  // Internal-only conversion factory; not part of public API surface despite being in public class.
  // ignore: library_private_types_in_public_api
  factory QuizQuestionView.fromInternal(_QuizQuestion q) => QuizQuestionView(
        prompt: q.prompt,
        correct: q.correct,
        options: List<String>.unmodifiable(q.options),
      );
}
