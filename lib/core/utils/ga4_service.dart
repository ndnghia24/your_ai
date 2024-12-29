import 'package:dio/dio.dart';

class GA4Service {
  final Dio _dio = Dio();

  final String measurementId = 'G-C40QYFPFM5';
  final String apiSecret = '64oNEZh-QEK_fhN4XhVLDA';
  String userId = 'default_user_id';

  Future<void> sendGA4Event(String eventName, Map<String, dynamic> parameters) async {
    final url = 'https://www.google-analytics.com/mp/collect?measurement_id=$measurementId&api_secret=$apiSecret';
    final body = {// You can use a unique identifier for the user
      'client_id': userId,
      'events': [
        {
          'name': eventName,
          'params': parameters,
        },
      ],
    };

    try {
      final response = await _dio.post(
        url,
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 204) {
        print('Event sent successfully');
      } else {
        print(response.statusCode);
        print('Failed to send event: ${response.data}');
      }
    } catch (e) {
      print('Error sending event: $e');
    }
  }
}

class GA4EventNames {
  static const String newChat = 'new_chat';
  static const String reloadConversation = 'reload_conversation';
  static const String usePrompt = 'use_prompt';
  static const String viewSubcription = 'view_subscription';
  static const String changeModel = 'change_model';
  static const String sendChatMessage = 'send_chat_message';
  static const String viewAdvertisement = 'view_advertisement';
  // Add more event names as needed
}