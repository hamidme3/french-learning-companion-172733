import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/app_theme.dart';
import 'state/app_state.dart';
import 'screens/home_shell.dart';

void main() {
  runApp(const FrenchLearningApp());
}

class FrenchLearningApp extends StatelessWidget {
  const FrenchLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (_) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'French Learning Companion',
        theme: AppTheme.lightTheme(),
        home: const HomeShell(),
      ),
    );
  }
}
