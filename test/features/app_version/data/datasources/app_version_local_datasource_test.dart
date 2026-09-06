import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sql_studio/src/features/app_version/data/datasources/app_version_local_datasource.dart';

void main() {
  test('getPackageInfo returns the platform package info', () async {
    PackageInfo.setMockInitialValues(
      appName: 'SQL Studio',
      packageName: 'br.com.dariomatias.sql_studio',
      version: '1.2.3',
      buildNumber: '42',
      buildSignature: '',
    );

    const datasource = AppVersionLocalDatasource();
    final info = await datasource.getPackageInfo();

    expect(info.version, '1.2.3');
    expect(info.buildNumber, '42');
  });
}
