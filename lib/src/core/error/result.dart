import 'dart:async';

import 'package:sql_studio/src/core/enums/app_localizations_key.dart';

/// Base class for an error that can be surfaced to the user.
abstract class Failure {
  /// Creates a failure identified by a localization [type] and optional
  /// [args] used to interpolate the localized message.
  const Failure(this.type, [this.args = const {}]);

  /// Localization key describing this failure.
  final AppLocalizationsKey type;

  /// Arguments interpolated into the localized failure message.
  final Map<String, Object?> args;
}

/// A failure originating from a database operation.
class DatabaseFailure extends Failure {
  /// Creates a database failure with the given localization [type] and
  /// optional [args].
  const DatabaseFailure(super.type, [super.args]);
}

/// A failure originating from general app logic.
class AppFailure extends Failure {
  /// Creates an app failure with the given localization [type] and
  /// optional [args].
  const AppFailure(super.type, [super.args]);
}

/// Describes the outcome of a successful database operation.
class DatabaseSuccess {
  /// Creates a database success, optionally carrying a localization
  /// [type], its [args], and the affected [result] rows.
  const DatabaseSuccess({this.type, this.result, this.args = const {}});

  /// Localization key describing this success, if any.
  final AppLocalizationsKey? type;

  /// Arguments interpolated into the localized success message.
  final Map<String, Object?> args;

  /// Rows affected or returned by the operation, if any.
  final List<Map<String, Object?>>? result;
}

/// Represents the result of an operation that can either succeed with a
/// value of type [T] or fail with a [Failure].
sealed class Result<T> {
  /// Const constructor for subclasses.
  const Result();

  /// Whether this result represents a success.
  bool get isSuccess => this is SuccessResult<T>;

  /// Whether this result represents a failure.
  bool get isFailure => this is FailureResult<T>;

  /// Returns [onSuccess] or [onFailure] applied to this result, whichever
  /// variant it is.
  R when<R>({
    required R Function(T value) onSuccess,
    required R Function(Failure error) onFailure,
  }) => switch (this) {
    SuccessResult<T>(:final value) => onSuccess(value),
    FailureResult<T>(:final error) => onFailure(error),
  };

  /// Returns a new result with a successful value mapped through
  /// [transform], carrying any failure over unchanged.
  Result<R> map<R>(R Function(T value) transform) => switch (this) {
    SuccessResult<T>(:final value) => SuccessResult(transform(value)),
    FailureResult<T>(:final error) => FailureResult(error),
  };

  /// Invokes [onSuccess] or [onFailure] depending on this result's variant.
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

/// A [Result] variant representing a failed operation.
final class FailureResult<T> extends Result<T> {
  /// Creates a failure result carrying the given [error].
  const FailureResult(this.error);

  /// The failure describing why the operation did not succeed.
  final Failure error;
}

/// A [Result] variant representing a successful operation.
final class SuccessResult<T> extends Result<T> {
  /// Creates a success result carrying the given [value].
  const SuccessResult(this.value);

  /// The value produced by the successful operation.
  final T value;
}
