import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sql_studio/src/core/app_colors.dart';
import 'package:sql_studio/src/shared/widgets/scaffold_widget.dart';

/// Shows the full license text of a single package, respecting each
/// paragraph's indentation/centering like Flutter's own license viewer.
class LicenseDetailScreen extends StatelessWidget {
  /// Creates the license detail screen for [packageName], displaying
  /// [paragraphs] in order.
  const LicenseDetailScreen({
    required this.packageName,
    required this.paragraphs,
    super.key,
  });

  /// Name of the package whose license is displayed.
  final String packageName;

  /// The license text, one entry per paragraph.
  final List<LicenseParagraph> paragraphs;

  static const double _indentUnit = 16;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(title: Text(packageName)),
      body: SelectionArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (final paragraph in paragraphs)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 16,
                    left: paragraph.indent > 0
                        ? paragraph.indent * _indentUnit
                        : 0,
                  ),
                  child: Text(
                    paragraph.text,
                    textAlign:
                        paragraph.indent == LicenseParagraph.centeredIndent
                        ? TextAlign.center
                        : TextAlign.start,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: AppColors.black,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
