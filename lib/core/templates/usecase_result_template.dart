class UsecaseResultTemplate<T> {
  final bool isSuccess;
  final T result;
  final String message;

  UsecaseResultTemplate({
    required this.isSuccess,
    required this.result,
    required this.message,
  });
}
