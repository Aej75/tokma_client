class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  ApiResponse({
    required this.success,
    required this.message,
    required this.data,
  });
}
class ApiResponseList<T> {
  final bool success;
  final String message;
  final List<T>? data;
  ApiResponseList({
    required this.success,
    required this.message,
    required this.data,
  });
}
