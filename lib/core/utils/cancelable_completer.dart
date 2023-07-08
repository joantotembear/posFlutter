import 'dart:async';

class CancelableCompleter {
  /// Create a simple instance that can be completed and canceled.
  CancelableCompleter() : _completer = Completer();

  /// Create an instance that completes automatically after [delay]
  /// or if canceled.
  CancelableCompleter.auto(Duration delay) : _completer = Completer() {
    _timer = Timer(delay, _complete);
  }

  final Completer<bool> _completer;
  late final Timer? _timer;

  bool _isCompleted = false;
  bool _isCanceled = false;

  /// Get the completer's future
  Future<bool> get future => _completer.future;

  /// Complete the future immediately with false.
  /// Cancels the auto completion if the instance was created with [auto].
  void cancel() {
    if (!isDone) {
      _timer?.cancel();
      _isCanceled = true;
      _completer.complete(false);
    }
  }

  /// Complete the future with true. Only for instances created with the main
  /// [CancelableCompleter] constructor (throws an [Exception] otherwise).
  void complete() {
    if (_timer != null) {
      throw Exception('complete must not be called'
          ' when using the "auto" constructor');
    }

    _complete();
  }

  /// Is it completed?
  bool get isCompleted => _isCompleted;

  /// Is it canceled?
  bool get isCanceled => _isCanceled;

  /// Is it canceled or completed?
  bool get isDone => _isCompleted || _isCanceled;

  // Handle the completion
  void _complete() {
    if (!isDone) {
      _isCompleted = true;
      _completer.complete(true);
    }
  }
}
