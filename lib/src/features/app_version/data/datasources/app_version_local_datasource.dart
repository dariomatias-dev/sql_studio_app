import 'package:package_info_plus/package_info_plus.dart';

/// Reads raw version info from the platform's package metadata.
class AppVersionLocalDatasource {
  /// Creates the datasource.
  const AppVersionLocalDatasource();

  /// Returns the platform's [PackageInfo], throwing on failure.
  Future<PackageInfo> getPackageInfo() => PackageInfo.fromPlatform();
}
