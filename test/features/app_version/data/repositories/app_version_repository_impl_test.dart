import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';
import 'package:sql_studio/src/core/logging/app_logger.dart';
import 'package:sql_studio/src/features/app_version/data/datasources/app_version_local_datasource.dart';
import 'package:sql_studio/src/features/app_version/data/repositories/app_version_repository_impl.dart';
import 'package:sql_studio/src/features/app_version/domain/entities/app_version_entity.dart';

class _MockDatasource extends Mock implements AppVersionLocalDatasource {}

class _MockLogger extends Mock implements AppLogger {}

void main() {
  late _MockDatasource datasource;
  late AppVersionRepositoryImpl repository;

  setUp(() {
    datasource = _MockDatasource();
    repository = AppVersionRepositoryImpl(datasource, _MockLogger());
  });

  test('returns the semantic version and build number on success', () async {
    when(() => datasource.getPackageInfo()).thenAnswer(
      (_) async => PackageInfo(
        appName: 'SQL Studio',
        packageName: 'com.example.sql_studio',
        version: '1.2.3',
        buildNumber: '42',
      ),
    );

    final result =
        await repository.getVersion() as SuccessResult<AppVersionEntity>;

    expect(result.value.semanticVersion, '1.2.3');
    expect(result.value.buildNumber, '42');
  });

  test('fails with failedToGetAppVersion when reading throws', () async {
    when(() => datasource.getPackageInfo()).thenThrow(Exception('boom'));

    final result =
        await repository.getVersion() as FailureResult<AppVersionEntity>;

    expect(result.error.type, AppLocalizationsKey.failedToGetAppVersion);
  });
}
