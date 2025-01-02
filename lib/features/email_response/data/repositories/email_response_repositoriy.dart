import 'package:your_ai/core/templates/data_sources_result_template.dart';
import 'package:your_ai/features/email_response/data/data_sources/email_response_datasource.dart';

class EmailResponseRepository {
  final EmailResponseRemoteDataSource _emailResponseRemoteDataSource;

  EmailResponseRepository(this._emailResponseRemoteDataSource);

  Future<Map<String, dynamic>> getEmailReplyIdeas({
    required String action,
    required String email,
    required Map<String, dynamic> metadata,
  }) async {
    final DataSourcesResultTemplate datasourceRes =
        await _emailResponseRemoteDataSource.getEmailReplyIdeas(
      action: action,
      email: email,
      metadata: metadata,
    );

    if (datasourceRes.isSuccess) {
      return datasourceRes.data;
    } else {
      throw Exception(datasourceRes.message);
    }
  }

  Future<Map<String, dynamic>> getReplyByIdea({
    required String mainIdea,
    required String action,
    required String email,
    required Map<String, dynamic> metadata,
  }) async {
    final DataSourcesResultTemplate datasourceRes =
        await _emailResponseRemoteDataSource.getReplyByIdea(
      mainIdea: mainIdea,
      action: action,
      email: email,
      metadata: metadata,
    );

    if (datasourceRes.isSuccess) {
      return datasourceRes.data;
    } else {
      throw Exception(datasourceRes.message);
    }
  }
}
