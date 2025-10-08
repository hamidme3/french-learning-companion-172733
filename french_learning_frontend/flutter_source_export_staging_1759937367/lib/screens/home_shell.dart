import 'package:flutter/material.dart';

import 'vocabulary_screen.dart';
import 'phrases_screen.dart';
import 'practice_screen.dart';

/// Main navigation shell with BottomNavigationBar and IndexedStack pages.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndex = 0;

  final _pages = const [
    VocabularyScreen(),
    PhrasesScreen(),
    PracticeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // A subtle gradient header container could wrap appBar if needed later.
    return Scaffold(
      appBar: AppBar(
        title: const Text('French Learning Companion'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() {
          _currentIndex = i;
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book_outlined), label: 'Vocabulary'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Phrases'),
          BottomNavigationBarItem(icon: Icon(Icons.school_outlined), label: 'Practice'),
        ],
      ),
    );
  }
}
