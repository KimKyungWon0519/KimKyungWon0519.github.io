class ResponseResult<T> {
  final bool isSuccess;
  final T? data;
  final Object? error;

  const ResponseResult({
    required this.isSuccess,
    this.data,
    this.error,
  });

  factory ResponseResult.isSuccess(T data) =>
      ResponseResult(isSuccess: true, data: data);

  factory ResponseResult.isFailure(Object error) =>
      ResponseResult(isSuccess: false, error: error);
}
