import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sql_studio/src/core/providers/core_providers.dart';
import 'package:sql_studio/src/features/app_version/data/datasources/app_version_local_datasource.dart';
import 'package:sql_studio/src/features/app_version/data/repositories/app_version_repository_impl.dart';
import 'package:sql_studio/src/features/app_version/domain/repositories/app_version_repository.dart';
import 'package:sql_studio/src/features/app_version/domain/usecases/get_app_version_usecase.dart';
import 'package:sql_studio/src/features/app_version/presentation/view_models/app_version_state.dart';
import 'package:sql_studio/src/features/app_version/presentation/view_models/app_version_view_model.dart';

/// Provides the raw platform version datasource.
final Provider<AppVersionLocalDatasource> appVersionLocalDatasourceProvider =
    Provider((ref) => const AppVersionLocalDatasource());

/// Provides the [AppVersionRepository] implementation.
final appVersionRepositoryProvider = Provider<AppVersionRepository>(
  (ref) => AppVersionRepositoryImpl(
    ref.watch(appVersionLocalDatasourceProvider),
    ref.watch(loggerProvider),
  ),
);

/// Provides the [GetAppVersionUseCase].
final Provider<GetAppVersionUseCase> getAppVersionUseCaseProvider = Provider(
  (ref) => GetAppVersionUseCase(ref.watch(appVersionRepositoryProvider)),
);

/// Exposes the [AppVersionViewModel] and its [AppVersionState].
final appVersionViewModelProvider =
    NotifierProvider<AppVersionViewModel, AppVersionState>(
      AppVersionViewModel.new,
    );
