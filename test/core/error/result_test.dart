import 'package:flutter_test/flutter_test.dart';
import 'package:sql_studio/src/core/enums/app_localizations_key.dart';
import 'package:sql_studio/src/core/error/result.dart';

void main() {
  group('SuccessResult', () {
    test('isSuccess is true and isFailure is false', () {
      const result = SuccessResult<int>(42);

      expect(result.isSuccess, isTrue);
      expect(result.isFailure, isFalse);
    });

    test('carries the produced value', () {
      const result = SuccessResult<String>('databases loaded');

      expect(result.value, 'databases loaded');
    });

    test('fold invokes onSuccess with the value, not onFailure', () async {
      const result = SuccessResult<int>(7);
      var onSuccessValue = 0;
      var onFailureCalled = false;

      await result.fold(
        onSuccess: (value) => onSuccessValue = value,
        onFailure: (_) => onFailureCalled = true,
      );

      expect(onSuccessValue, 7);
      expect(onFailureCalled, isFalse);
    });
  });

  group('FailureResult', () {
    test('isFailure is true and isSuccess is false', () {
      const result = FailureResult<int>(
        DatabaseFailure(AppLocalizationsKey.toDoListLabel),
      );

      expect(result.isFailure, isTrue);
      expect(result.isSuccess, isFalse);
    });

    test('carries the originating error', () {
      const failure = DatabaseFailure(AppLocalizationsKey.toDoListLabel);
      const result = FailureResult<void>(failure);

      expect(result.error, same(failure));
    });

    test('fold invokes onFailure with the error, not onSuccess', () async {
      const failure = AppFailure(AppLocalizationsKey.toDoListLabel);
      const result = FailureResult<int>(failure);
      var onFailureError = 0;
      var onSuccessCalled = false;

      await result.fold(
        onSuccess: (_) => onSuccessCalled = true,
        onFailure: (error) => onFailureError = error == failure ? 1 : -1,
      );

      expect(onFailureError, 1);
      expect(onSuccessCalled, isFalse);
    });
  });
}
