import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sql_studio/src/features/app_version/presentation/view_models/app_version_state.dart';
import 'package:sql_studio/src/features/app_version/presentation/view_models/app_version_view_model.dart';

/// Exposes the [AppVersionViewModel] and its [AppVersionState].
final appVersionViewModelProvider =
    NotifierProvider<AppVersionViewModel, AppVersionState>(
      AppVersionViewModel.new,
    );
