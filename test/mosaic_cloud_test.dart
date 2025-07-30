import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mosaic_cloud/mosaic_cloud.dart';

void main() {
  group('MosaicCloud Widget Tests', () {
    testWidgets('renders correctly with multiple children',
        (WidgetTester tester) async {
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

    testWidgets('renders correctly with an empty list of children',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MosaicCloud(
              children: [],
            ),
          ),
        ),
      );

      expect(find.byType(MosaicCloud), findsOneWidget);
      expect(find.byType(Container), findsNothing);
    });

    testWidgets('renders correctly with a single child',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MosaicCloud(
              children: [
                SizedBox(
                    key: const Key('singleChild'), width: 100, height: 100),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(MosaicCloud), findsOneWidget);
      expect(find.byKey(const Key('singleChild')), findsOneWidget);
    });
  });

  group('MosaicLayoutDelegate Unit Tests', () {
    test('shouldRelayout returns true when childCount changes', () {
      final oldDelegate = MosaicLayoutDelegate(childCount: 5, spacing: 4.0);
      final newDelegate = MosaicLayoutDelegate(childCount: 10, spacing: 4.0);
      expect(newDelegate.shouldRelayout(oldDelegate), isTrue);
    });

    test('shouldRelayout returns true when spacing changes', () {
      final oldDelegate = MosaicLayoutDelegate(childCount: 5, spacing: 4.0);
      final newDelegate = MosaicLayoutDelegate(childCount: 5, spacing: 8.0);
      expect(newDelegate.shouldRelayout(oldDelegate), isTrue);
    });

    test('shouldRelayout returns false when delegate properties are the same',
        () {
      final oldDelegate = MosaicLayoutDelegate(childCount: 5, spacing: 4.0);
      final newDelegate = MosaicLayoutDelegate(childCount: 5, spacing: 4.0);
      expect(newDelegate.shouldRelayout(oldDelegate), isFalse);
    });
  });
}
