class ResponseResult<T> {
  final bool isSuccess;
  final T? data;
  final String? message;

  const ResponseResult({
    required this.isSuccess,
    this.data,
    this.message,
  });
}
