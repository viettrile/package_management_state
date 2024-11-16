import 'dart:async';

class AsyncHandler {
  static Timer? _debounceTimer;

  static Future<T> handleAsync<T>({
    required Future<T> Function() action,
    required Function(T) onSuccess,
    required Function(String) onError,
    required Function() onLoading,
    Duration? timeout,
  }) async {
    try {
      onLoading();
      final result = await action().timeout(
        timeout ?? const Duration(seconds: 30),
        onTimeout: () => throw TimeoutException('Request timeout'),
      );
      onSuccess(result);
      return result;
    } catch (e) {
      onError(e.toString());
      rethrow;
    }
  }

  static Future<void> debounce(
    Duration duration,
    Future<void> Function() action,
  ) async {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    _debounceTimer = Timer(duration, () async {
      await action();
      _debounceTimer = null;
    });
  }

  static void cancelDebounce() {
    _debounceTimer?.cancel();
    _debounceTimer = null;
  }
}
