class ResponseResult<T> {
  final bool isSuccess;
  final T? data;
  final Exception? exception;

  const ResponseResult({
    required this.isSuccess,
    this.data,
    this.exception,
  });

  factory ResponseResult.isSuccess(T data) =>
      ResponseResult(isSuccess: true, data: data);

  factory ResponseResult.isFailure(Exception exception) =>
      ResponseResult(isSuccess: false, exception: exception);
}
