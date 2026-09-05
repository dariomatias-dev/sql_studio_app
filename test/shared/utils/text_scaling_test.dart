import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/shared/utils/text_scaling.dart';

void main() {
  Future<TextScaler> scalerUnder(WidgetTester tester, double platform) async {
    late TextScaler scaler;

    await tester.pumpWidget(
      MediaQuery(
        data: MediaQueryData(textScaler: TextScaler.linear(platform)),
        child: Builder(
          builder: (context) => clampTextScaling(
            context,
            Builder(
              builder: (inner) {
                scaler = MediaQuery.textScalerOf(inner);

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );

    return scaler;
  }

  testWidgets('caps the platform text scale', (tester) async {
    final scaler = await scalerUnder(tester, 3);

    expect(scaler.scale(10), 10 * maxTextScaleFactor);
  });

  testWidgets('leaves a smaller scale untouched', (tester) async {
    final scaler = await scalerUnder(tester, 0.8);

    expect(scaler.scale(10), closeTo(8, 0.001));
  });

  testWidgets('renders a placeholder when the child is null', (tester) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(),
        child: Builder(builder: (context) => clampTextScaling(context, null)),
      ),
    );

    expect(find.byType(SizedBox), findsOneWidget);
  });
}
