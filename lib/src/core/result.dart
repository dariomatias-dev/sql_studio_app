import 'dart:async';

import 'package:sql_studio/src/core/enums/app_localizations_key.dart';

abstract class Failure {
  final AppLocalizationsKey type;
  final Map<String, Object?> args;

  const Failure(this.type, [this.args = const {}]);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.type, [super.args]);
}

class AppFailure extends Failure {
  const AppFailure(super.type, [super.args]);
}

sealed class Result<T> {
  const Result();

  bool get isSuccess => this is SuccessResult<T>;
  bool get isFailure => this is FailureResult<T>;

  FutureOr<void> fold({
    FutureOr<void> Function(T value)? onSuccess,
    FutureOr<void> Function(Failure error)? onFailure,
  }) async {
    if (this is SuccessResult<T>) {
      if (onSuccess != null) {
        await onSuccess((this as SuccessResult<T>).value);
      }
    } else if (this is FailureResult<T>) {
      if (onFailure != null) {
        await onFailure((this as FailureResult<T>).error);
      }
    }
  }
}

final class FailureResult<T> extends Result<T> {
  final Failure error;

  const FailureResult(this.error);
}

final class SuccessResult<T> extends Result<T> {
  final T value;

  const SuccessResult(this.value);
}
