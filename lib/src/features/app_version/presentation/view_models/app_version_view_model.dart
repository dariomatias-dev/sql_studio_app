import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/app_version/data/providers/app_version_data_providers.dart';
import 'package:sql_studio/src/features/app_version/data/repositories/app_version_repository_impl.dart';
import 'package:sql_studio/src/features/app_version/presentation/view_models/app_version_state.dart';

/// Loads and exposes the application's current build version.
class AppVersionViewModel extends Notifier<AppVersionState> {
  late final AppVersionRepositoryImpl _repository;

  @override
  AppVersionState build() {
    _repository = ref.read(appVersionRepositoryProvider);

    return const AppVersionState();
  }

  /// Loads the application version from the platform.
  Future<Result<void>> load() async {
    final result = await _repository.getVersion();

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
