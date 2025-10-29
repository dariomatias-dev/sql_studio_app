import 'dart:async';

abstract class Failure {
  final String message;

  const Failure(this.message);
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
