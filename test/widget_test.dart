// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:hive_example/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    // Initialize Hive for testing
    await Hive.initFlutter();
    final box = await Hive.openBox('testBox');

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(box: box));

    // Verify that the app title is displayed
    expect(find.text('User Management'), findsOneWidget);

    // Verify that the form fields are present
    expect(find.byType(TextFormField), findsNWidgets(3));

    // Verify that the save button is present
    expect(find.text('Save User'), findsOneWidget);

    // Verify that the saved users section is present
    expect(find.text('Saved Users'), findsOneWidget);
  });
}
