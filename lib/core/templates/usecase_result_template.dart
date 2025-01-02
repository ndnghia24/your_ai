import 'package:your_ai/core/templates/data_sources_result_template.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/knowledge_model.dart';

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
