import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/features/app_version/domain/entities/app_version_entity.dart';
import 'package:sql_studio/src/features/app_version/domain/usecases/get_app_version_usecase.dart';

void main() {
  test('returns whatever the injected version reader produces', () async {
    const entity = AppVersionEntity(semanticVersion: '1.0.0', buildNumber: '1');
    final useCase = GetAppVersionUseCase(
      () async => const SuccessResult(entity),
    );

    final result = await useCase() as SuccessResult<AppVersionEntity>;

    expect(result.value, same(entity));
  });
}
