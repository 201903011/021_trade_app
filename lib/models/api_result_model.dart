class Result<T> {
  final T? data;
  final String? error;
  final String? message;

  Result.success(this.data, {String? msg})
      : error = null,
        message = msg;

  Result.failure(this.error)
      : data = null,
        message = null;

  Result.initial()
      : data = null,
        error = null,
        message = null;

  bool get isSuccess => data != null;
}
