import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// QuizCard displays the prompt and four options.
/// It shows correct/incorrect styling after selection.
class QuizCard extends StatelessWidget {
  final String prompt;
  final List<String> options;
  final String? selected;
  final String correct;
  final bool answered;
  final ValueChanged<String> onSelect;

  const QuizCard({
    super.key,
    required this.prompt,
    required this.options,
    required this.selected,
    required this.correct,
    required this.answered,
    required this.onSelect,
  });

  Color _optionColor(BuildContext context, String option) {
    if (!answered) return Theme.of(context).colorScheme.surface;
    if (option == correct) return const Color(0xFFD1FAE5); // green-100
    if (option == selected) return const Color(0xFFFEE2E2); // red-100
    return Theme.of(context).colorScheme.surface;
  }

  Color _optionBorder(BuildContext context, String option) {
    if (!answered) return const Color(0xFFE5E7EB);
    if (option == correct) return const Color(0xFF10B981); // green-500
    if (option == selected) return const Color(0xFFEF4444); // red-500
    return const Color(0xFFE5E7EB);
  }

  IconData? _optionIcon(String option) {
    if (!answered) return null;
    if (option == correct) return Icons.check_circle;
    if (option == selected) return Icons.cancel;
    return null;
  }

  Color? _iconColor(String option) {
    if (!answered) return null;
    if (option == correct) return const Color(0xFF10B981);
    if (option == selected) return const Color(0xFFEF4444);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: AppTheme.headerGradient,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Text(
                prompt,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 12),
            for (final option in options)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: GestureDetector(
                  onTap: answered ? null : () => onSelect(option),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    decoration: BoxDecoration(
                      color: _optionColor(context, option),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      border: Border.all(color: _optionBorder(context, option), width: 1.25),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            option,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        if (_optionIcon(option) != null)
                          Icon(
                            _optionIcon(option),
                            color: _iconColor(option),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
