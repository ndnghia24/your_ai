import 'package:your_ai/core/templates/data_sources_result_template.dart';
import 'package:your_ai/features/email_response/data/data_sources/services/email_response_service.dart';

class EmailResponseRemoteDataSource {
  final EmailResponseService _emailResponseService;

  EmailResponseRemoteDataSource(this._emailResponseService);

  /// Gửi yêu cầu lấy ý tưởng phản hồi email
  Future<DataSourcesResultTemplate> getEmailReplyIdeas({
    required String action,
    required String email,
    required Map<String, dynamic> metadata,
  }) async {
    try {
      final response = await _emailResponseService.getEmailReplyIdeas({
        "action": action,
        "email": email,
        "metadata": metadata,
      });

      if (response.statusCode == 200) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: '[DataSource] Email reply ideas fetched successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message:
              '[DataSource] Error occurred during fetching email reply ideas',
        );
      }
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: e.toString(),
        message: 'Error occurred: ${e.toString()}',
      );
    }
  }

  /// Gửi yêu cầu tạo phản hồi dựa trên ý tưởng
  Future<DataSourcesResultTemplate> getReplyByIdea({
    required String mainIdea,
    required String action,
    required String email,
    required Map<String, dynamic> metadata,
  }) async {
    try {
      final response = await _emailResponseService.getReplyByIdea({
        "mainIdea": mainIdea,
        "action": action,
        "email": email,
        "metadata": metadata,
      });

      if (response.statusCode == 200) {
        return DataSourcesResultTemplate(
          isSuccess: true,
          data: response.data,
          message: '[DataSource] Email reply generated successfully',
        );
      } else {
        return DataSourcesResultTemplate(
          isSuccess: false,
          data: response.data,
          message: '[DataSource] Error occurred during generating email reply',
        );
      }
    } catch (e) {
      return DataSourcesResultTemplate(
        isSuccess: false,
        data: e.toString(),
        message: 'Error occurred: ${e.toString()}',
      );
    }
  }
}
