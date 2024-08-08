class BucketFile {
  final String fileName;
  final String url;

  const BucketFile({required this.fileName, required this.url});

  @override
  String toString() {
    return '$url/$fileName';
  }
}
