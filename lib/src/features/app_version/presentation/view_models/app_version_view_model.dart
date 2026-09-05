import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/app_version/domain/usecases/get_app_version_usecase.dart';
import 'package:sql_studio/src/features/app_version/presentation/providers.dart';
import 'package:sql_studio/src/features/app_version/presentation/view_models/app_version_state.dart';

/// Loads and exposes the application's current build version.
class AppVersionViewModel extends Notifier<AppVersionState> {
  late final GetAppVersionUseCase _getAppVersion;

  @override
  AppVersionState build() {
    _getAppVersion = ref.read(getAppVersionUseCaseProvider);

    return const AppVersionState();
  }

  /// Loads the application version from the platform.
  Future<Result<void>> load() async {
    final result = await _getAppVersion();

    return result.when(
      onSuccess: (version) {
        state = state.copyWith(formattedVersion: version.formatted);

        return const SuccessResult(null);
      },
      onFailure: (error) {
        state = state.copyWith(formattedVersion: '-.-.-');

        return FailureResult(error);
      },
    );
  }
}
