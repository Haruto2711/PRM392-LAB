// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:lab1/lab9/lab9.dart';

void main() {
  testWidgets('Lab9 app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const Lab9App());

    // Verify that our lab 9 title is shown.
    expect(find.text('Lab 9: Local JSON Storage'), findsOneWidget);
  });
}
