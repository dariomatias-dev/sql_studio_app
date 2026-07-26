import 'package:fluttertoast/fluttertoast.dart';
import 'package:sql_studio/src/core/app_colors.dart';

/// Shows short, transient feedback messages with the app's single,
/// consistent toast style.
class AppToast {
  const AppToast._();

  /// Shows [message] in a toast styled consistently across the app.
  static Future<void> show(String message) {
    return Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.black,
      textColor: AppColors.white,
      fontSize: 14,
    );
  }
}
