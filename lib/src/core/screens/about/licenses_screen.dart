import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sql_studio/l10n/app_localizations.dart';
import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/core/screens/about/license_detail_screen.dart';
import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';
import 'package:sql_studio/src/shared/widgets/states/loading_state_widget.dart';

class _PackageLicense {
  _PackageLicense(this.name);

  final String name;
  final List<LicenseParagraph> paragraphs = [];
}

Future<List<_PackageLicense>> _loadPackageLicenses() async {
  final packages = <String, _PackageLicense>{};

  await for (final entry in LicenseRegistry.licenses) {
    for (final package in entry.packages) {
      final license = packages.putIfAbsent(
        package,
        () => _PackageLicense(package),
      );

      license.paragraphs.addAll(entry.paragraphs);
    }
  }

  return packages.values.toList()..sort((a, b) => a.name.compareTo(b.name));
}

/// Lists every third-party package bundled with the app, each linking to
/// its full license text, styled to match the rest of the app instead of
/// Flutter's default [LicensePage].
class LicensesScreen extends StatefulWidget {
  /// Creates the licenses screen.
  const LicensesScreen({super.key});

  @override
  State<LicensesScreen> createState() => _LicensesScreenState();
}

class _LicensesScreenState extends State<LicensesScreen> {
  late final Future<List<_PackageLicense>> _licenses = _loadPackageLicenses();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ScaffoldWidget(
      appBar: AppBar(title: Text(l10n.licenses)),
      body: FutureBuilder<List<_PackageLicense>>(
        future: _licenses,
        builder: (context, snapshot) {
          final packages = snapshot.data;
          if (packages == null) return const LoadingStateWidget();

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: packages.length + 1,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, thickness: 1, color: AppColors.border),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Text(
                    l10n.packagesCount(packages.length),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMuted,
                    ),
                  ),
                );
              }

              final package = packages[index - 1];

              return ListTile(
                title: Text(
                  package.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textMuted,
                ),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => LicenseDetailScreen(
                      packageName: package.name,
                      paragraphs: package.paragraphs,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
