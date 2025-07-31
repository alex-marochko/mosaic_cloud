import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mosaic_cloud/mosaic_cloud.dart';

void main() {
  group('MosaicCloud Widget Tests', () {
    testWidgets('renders correctly with multiple children', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MosaicCloud(
              children: [
                SizedBox(key: const Key('child1'), width: 50, height: 50),
                SizedBox(key: const Key('child2'), width: 60, height: 40),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(MosaicCloud), findsOneWidget);
      expect(find.byKey(const Key('child1')), findsOneWidget);
      expect(find.byKey(const Key('child2')), findsOneWidget);
    });

    testWidgets('renders correctly with an empty list of children', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: MosaicCloud(children: []))),
      );

      expect(find.byType(MosaicCloud), findsOneWidget);
    });

    testWidgets('renders correctly with a single child', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MosaicCloud(
              children: [
                SizedBox(
                  key: const Key('singleChild'),
                  width: 100,
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(MosaicCloud), findsOneWidget);
      expect(find.byKey(const Key('singleChild')), findsOneWidget);
    });
  });

  group('MosaicCloud Golden Tests', () {
    testWidgets('renders a basic layout consistently', (
      WidgetTester tester,
    ) async {
      final widgetToTest = MosaicCloud(
        spacing: 8.0,
        children: [
          Container(color: Colors.blue, width: 100, height: 50),
          Container(color: Colors.green, width: 70, height: 70),
          Container(color: Colors.red, width: 50, height: 120),
          Container(color: Colors.yellow, width: 80, height: 40),
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: widgetToTest,
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(MosaicCloud),
        matchesGoldenFile('goldens/basic_layout.png'),
      );
    });
  });
}