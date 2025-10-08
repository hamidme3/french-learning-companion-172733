import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../widgets/quiz_card.dart';

/// Interactive quiz practice screen with scoring and progress.
class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final questions = state.quizQuestions;
    if (questions.isEmpty) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }
    final question = state.currentQuestion;
    final total = questions.length;
    final idx = state.quizIndex + 1;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Text('Practice', style: Theme.of(context).textTheme.headlineSmall),
              const Spacer(),
              Chip(label: Text('${state.quizScore}/$total score')),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: idx / total,
            minHeight: 8,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          const SizedBox(height: 16),
          QuizCard(
            prompt: question.prompt,
            options: question.options,
            selected: state.lastSelectedOption,
            correct: question.correct,
            answered: state.quizAnswered,
            onSelect: (opt) {
              // Only update primitive state via provider method; UI reacts accordingly.
              state.answer(opt);
            },
          ),
          const Spacer(),
          Row(
            children: [
              if (state.quizAnswered && state.quizIndex < total - 1)
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => state.nextQuestion(),
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Next'),
                  ),
                )
              else if (state.quizIndex >= total - 1)
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => state.restartQuiz(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Restart'),
                  ),
                )
              else
                Expanded(
                  child: Text(
                    'Question $idx of $total',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
