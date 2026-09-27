import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:health_bridge/main.dart';

void main() {
  testWidgets('Login screen shows', (WidgetTester tester) async {
    await tester.pumpWidget(const HealthBridgeApp());

    expect(find.text('Health Bridge'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
  });
}
