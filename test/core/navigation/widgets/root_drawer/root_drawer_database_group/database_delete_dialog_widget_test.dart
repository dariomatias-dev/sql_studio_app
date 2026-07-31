import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_theme.dart';
import 'package:sql_studio/src/core/navigation/widgets/root_drawer/root_drawer_database_group/database_delete_dialog_widget.dart';

void main() {
  Future<void> pumpAndOpen(WidgetTester tester, VoidCallback onDelete) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => DatabaseDeleteDialogWidget.show(
                  context,
                  onDeleteDatabase: onDelete,
                ),
                child: const Text('open'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  testWidgets('shows the confirmation title and description', (tester) async {
    await pumpAndOpen(tester, () {});

    expect(find.text('Attention'), findsOneWidget);
    expect(
      find.text(
        'Are you sure you want to permanently delete this database? '
        'This action cannot be undone.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('confirming the deletion invokes the callback', (tester) async {
    var deleted = false;

    await pumpAndOpen(tester, () => deleted = true);

    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(deleted, isTrue);
  });

  testWidgets('cancelling dismisses the dialog without invoking the '
      'callback', (tester) async {
    var deleted = false;

    await pumpAndOpen(tester, () => deleted = true);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(deleted, isFalse);
    expect(find.byType(DatabaseDeleteDialogWidget), findsNothing);
  });
}
