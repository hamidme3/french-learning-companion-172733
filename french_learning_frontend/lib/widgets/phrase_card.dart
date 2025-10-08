import 'package:flutter/material.dart';

import '../models/phrase_item.dart';
import '../theme/app_theme.dart';

/// Card UI for a phrase item with context chip and favorite toggle.
class PhraseCard extends StatelessWidget {
  final PhraseItem item;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const PhraseCard({
    super.key,
    required this.item,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final favColor = isFavorite ? AppTheme.secondary : const Color(0xFF9CA3AF);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        child: Row(
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.french, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text(
                      item.english,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF6B7280)),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Chip(
                        label: Text(item.context),
                        backgroundColor: const Color(0xFFF3F4F6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Semantics(
              label: 'Toggle favorite for ${item.french}',
              button: true,
              child: IconButton(
                onPressed: onToggleFavorite,
                icon: Icon(isFavorite ? Icons.star : Icons.star_border),
                color: favColor,
                tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
