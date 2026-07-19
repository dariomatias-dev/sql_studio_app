import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/app_version/domain/entities/app_version_entity.dart';
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

    if (result is SuccessResult<AppVersionEntity>) {
      state = state.copyWith(formattedVersion: result.value.formatted);

      return const SuccessResult(null);
    }

    state = state.copyWith(formattedVersion: '-.-.-');

    return FailureResult((result as FailureResult<AppVersionEntity>).error);
  }
}
