class DataSourcesResultTemplate {
  final bool isSuccess;
  final dynamic data;
  final String message;

  const DataSourcesResultTemplate({
    required this.isSuccess,
    required this.data,
    required this.message,
  });

  factory DataSourcesResultTemplate.fromMap(Map<String, dynamic> map) {
    return DataSourcesResultTemplate(
      isSuccess: map['isSuccess'] ?? false,
      data: map['data'] ?? {},
      message: map['message'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isSuccess': isSuccess,
      'data': data,
      'message': message,
    };
  }
}
