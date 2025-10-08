import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../widgets/phrase_card.dart';
import '../theme/app_theme.dart';

/// Displays phrasebook with local search and favorite toggles.
class PhrasesScreen extends StatefulWidget {
  const PhrasesScreen({super.key});

  @override
  State<PhrasesScreen> createState() => _PhrasesScreenState();
}

class _PhrasesScreenState extends State<PhrasesScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final favSet = appState.favorites;

    final filtered = appState.phrases.where((p) {
      if (_query.isEmpty) return true;
      final q = _query.toLowerCase();
      return p.french.toLowerCase().contains(q) || p.english.toLowerCase().contains(q) || p.context.toLowerCase().contains(q);
    }).toList();

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          decoration: const BoxDecoration(gradient: AppTheme.headerGradient),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Phrases', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Search phrases or English meaning',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) => setState(() => _query = value),
              ),
            ],
          ),
        ),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: ListView.builder(
              key: ValueKey(_query),
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final item = filtered[index];
                final isFav = favSet.contains(item.id);
                return PhraseCard(
                  item: item,
                  isFavorite: isFav,
                  onToggleFavorite: () => appState.toggleFavorite(item.id),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
