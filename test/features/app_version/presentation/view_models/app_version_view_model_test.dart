import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/app_version/domain/entities/app_version_entity.dart';
import 'package:sql_studio/src/features/app_version/domain/usecases/get_app_version_usecase.dart';
import 'package:sql_studio/src/features/app_version/presentation/providers.dart';

void main() {
  ProviderContainer buildContainer(GetAppVersionUseCase useCase) {
    final container = ProviderContainer(
      overrides: [getAppVersionUseCaseProvider.overrideWithValue(useCase)],
    );
    addTearDown(container.dispose);

    return container;
  }

  test('load sets the formatted version on success', () async {
    final container = buildContainer(
      GetAppVersionUseCase(
        () async => const SuccessResult(
          AppVersionEntity(semanticVersion: '1.2.3', buildNumber: '42'),
        ),
      ),
    );
    final notifier = container.read(appVersionViewModelProvider.notifier);

    final result = await notifier.load();

    expect(result.isSuccess, isTrue);
    expect(
      container.read(appVersionViewModelProvider).formattedVersion,
      '1.2.3+42',
    );
  });

  test('load falls back to the placeholder version on failure', () async {
    final container = buildContainer(
      GetAppVersionUseCase(
        () async => const FailureResult(
          AppFailure(AppLocalizationsKey.failedToGetAppVersion),
        ),
      ),
    );
    final notifier = container.read(appVersionViewModelProvider.notifier);

    final result = await notifier.load();

    expect(result.isFailure, isTrue);
    expect(
      container.read(appVersionViewModelProvider).formattedVersion,
      '-.-.-',
    );
  });
}
