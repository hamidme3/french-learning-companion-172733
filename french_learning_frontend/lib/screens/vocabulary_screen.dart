import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../widgets/vocab_card.dart';
import '../theme/app_theme.dart';

enum VocabFilter { all, favorites, learned }

/// Displays vocabulary with FilterChips and animated list of cards.
class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key});

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  VocabFilter _filter = VocabFilter.all;

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final all = appState.vocabulary;
    final favSet = appState.favorites;
    final learnedSet = appState.learned;

    final filtered = switch (_filter) {
      VocabFilter.all => all,
      VocabFilter.favorites => all.where((v) => favSet.contains(v.id)).toList(),
      VocabFilter.learned => all.where((v) => learnedSet.contains(v.id)).toList(),
    };

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          decoration: const BoxDecoration(
            gradient: AppTheme.headerGradient,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Vocabulary', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  FilterChip(
                    label: Text('All (${all.length})'),
                    selected: _filter == VocabFilter.all,
                    onSelected: (_) => setState(() => _filter = VocabFilter.all),
                  ),
                  FilterChip(
                    label: Text('Favorites (${favSet.length})'),
                    selected: _filter == VocabFilter.favorites,
                    onSelected: (_) => setState(() => _filter = VocabFilter.favorites),
                  ),
                  FilterChip(
                    label: Text('Learned (${learnedSet.length})'),
                    selected: _filter == VocabFilter.learned,
                    onSelected: (_) => setState(() => _filter = VocabFilter.learned),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: ListView.builder(
              key: ValueKey(_filter),
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final item = filtered[index];
                final isFav = favSet.contains(item.id);
                final isLearned = learnedSet.contains(item.id);
                return VocabCard(
                  item: item,
                  isFavorite: isFav,
                  isLearned: isLearned,
                  onToggleFavorite: () => appState.toggleFavorite(item.id),
                  onToggleLearned: () => appState.toggleLearned(item.id),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
