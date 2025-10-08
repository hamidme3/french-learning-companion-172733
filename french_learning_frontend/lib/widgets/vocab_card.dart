import 'package:flutter/material.dart';

import '../models/vocab_item.dart';
import '../theme/app_theme.dart';

/// Card UI for a single vocabulary item with favorite and learned toggles.
class VocabCard extends StatelessWidget {
  final VocabItem item;
  final bool isFavorite;
  final bool isLearned;
  final VoidCallback onToggleFavorite;
  final VoidCallback onToggleLearned;

  const VocabCard({
    super.key,
    required this.item,
    required this.isFavorite,
    required this.isLearned,
    required this.onToggleFavorite,
    required this.onToggleLearned,
  });

  @override
  Widget build(BuildContext context) {
    final favColor = isFavorite ? AppTheme.secondary : const Color(0xFF9CA3AF);
    final learnedColor = isLearned ? AppTheme.primary : const Color(0xFF9CA3AF);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onToggleLearned,
        child: Stack(
          children: [
            // Accent stripe
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 6,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: AppTheme.headerGradient,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
              child: Row(
                children: [
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.only(left: 4, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.french,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.english,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF6B7280)),
                          ),
                          const SizedBox(height: 6),
                          if (item.exampleSentence != null)
                            Text(
                              item.exampleSentence!,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: const Color(0xFF6B7280)),
                            ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: [
                              Chip(
                                label: Text(item.category),
                                backgroundColor: const Color(0xFFF3F4F6),
                              ),
                              if (isLearned)
                                const Chip(
                                  label: Text('Learned'),
                                  backgroundColor: Color(0xFFE0F2FE),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: onToggleFavorite,
                        icon: Icon(isFavorite ? Icons.star : Icons.star_border),
                        color: favColor,
                        tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
                        semanticLabel: 'Toggle favorite for ${item.french}',
                      ),
                      IconButton(
                        onPressed: onToggleLearned,
                        icon: Icon(isLearned ? Icons.check_circle : Icons.check_circle_outline),
                        color: learnedColor,
                        tooltip: isLearned ? 'Mark as unlearned' : 'Mark as learned',
                        semanticLabel: 'Toggle learned for ${item.french}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
