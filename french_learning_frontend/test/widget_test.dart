import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:french_learning_frontend/main.dart';

void main() {
  testWidgets('Bottom navigation has three tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const FrenchLearningApp());
    await tester.pumpAndSettle();

    expect(find.text('Vocabulary'), findsOneWidget);
    expect(find.text('Phrases'), findsOneWidget);
    expect(find.text('Practice'), findsOneWidget);
  });

  testWidgets('App renders home shell', (WidgetTester tester) async {
    await tester.pumpWidget(const FrenchLearningApp());
    await tester.pump();

    expect(find.byIcon(Icons.book_outlined), findsOneWidget);
    expect(find.byIcon(Icons.chat_bubble_outline), findsOneWidget);
    expect(find.byIcon(Icons.school_outlined), findsOneWidget);
  });
}
