import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:french_learning_frontend/main.dart';

void main() {
  testWidgets('BottomNavigationBar shows Vocabulary, Phrases, Practice labels', (WidgetTester tester) async {
    await tester.pumpWidget(const FrenchLearningApp());
    await tester.pumpAndSettle();

    // Scope text expectations to the BottomNavigationBar to avoid duplicates elsewhere in UI.
    final bottomNavFinder = find.byType(BottomNavigationBar);
    expect(bottomNavFinder, findsOneWidget);

    expect(find.descendant(of: bottomNavFinder, matching: find.widgetWithText(BottomNavigationBar, 'Vocabulary')), findsOneWidget);
    expect(find.descendant(of: bottomNavFinder, matching: find.widgetWithText(BottomNavigationBar, 'Phrases')), findsOneWidget);
    expect(find.descendant(of: bottomNavFinder, matching: find.widgetWithText(BottomNavigationBar, 'Practice')), findsOneWidget);
  });

  testWidgets('Home shell renders with bottom navigation icons', (WidgetTester tester) async {
    await tester.pumpWidget(const FrenchLearningApp());
    await tester.pump();

    // Focused on BottomNavigationBar icons existence, not global texts.
    final bottomNavFinder = find.byType(BottomNavigationBar);
    expect(bottomNavFinder, findsOneWidget);

    expect(find.descendant(of: bottomNavFinder, matching: find.byIcon(Icons.book_outlined)), findsOneWidget);
    expect(find.descendant(of: bottomNavFinder, matching: find.byIcon(Icons.chat_bubble_outline)), findsOneWidget);
    expect(find.descendant(of: bottomNavFinder, matching: find.byIcon(Icons.school_outlined)), findsOneWidget);
  });
}
