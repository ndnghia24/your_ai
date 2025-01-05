import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/configs/service_locator.dart';
import 'package:your_ai/core/theme/app_colors.dart';
import 'package:your_ai/features/knowledge_base/domain/enums/upload_type.dart';
import 'package:your_ai/features/knowledge_base/domain/knowledge_usecase_factory.dart';
import 'package:your_ai/features/knowledge_base/presentation/blocs/unit_bloc.dart';
import 'package:your_ai/features/knowledge_base/presentation/blocs/unit_event.dart';

final getIt = GetIt.instance;

class UploadWebsiteScreen extends StatefulWidget {
  final String knowledgeId;
  const UploadWebsiteScreen({super.key, required this.knowledgeId});

  @override
  _UploadWebsiteScreenState createState() => _UploadWebsiteScreenState();
}

class _UploadWebsiteScreenState extends State<UploadWebsiteScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _webUrlController = TextEditingController();
  final KnowledgeUseCaseFactory _useCaseFactory =
      locator<KnowledgeUseCaseFactory>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  bool _isValidUrl(String url) {
    final Uri? uri = Uri.tryParse(url);
    return uri != null && uri.host.isNotEmpty;
  }

  void _connect() async {
    final name = _nameController.text;
    String webUrl = _webUrlController.text;

    if (name.isEmpty || webUrl.isEmpty) {
      Fluttertoast.showToast(msg: 'Name and Web URL cannot be empty');
      return;
    }

    if (!webUrl.startsWith('http://') && !webUrl.startsWith('https://')) {
      webUrl = 'http://$webUrl';
    }

    if (!_isValidUrl(webUrl)) {
      Fluttertoast.showToast(msg: 'Invalid Web URL format');
      return;
    }

    // Ẩn bàn phím
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });

    try {
      final result =
          await _useCaseFactory.uploadKnowledgeDataSourceUseCase.execute(
        widget.knowledgeId,
        UploadType.websiteContent,
        unitName: name,
        webUrl: webUrl,
      );

      if (result.isSuccess) {
        getIt<UnitBloc>().add(GetAllUnitEvent(widget.knowledgeId));
        Fluttertoast.showToast(msg: 'Upload successful');
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
            msg:
                'Cannot upload website content, your website may not be accessible or there is a network error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error during upload: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Website'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Upload Website Content:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      color: Colors.black, // Thay đổi màu của label ở đây
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _webUrlController,
                  decoration: InputDecoration(
                    labelText: 'Web URL',
                    labelStyle: TextStyle(
                      color: Colors.black, // Thay đổi màu của label ở đây
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _connect,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Connect',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_isLoading)
            ModalBarrier(
              color: Colors.white.withOpacity(0.5),
              dismissible: false,
            ),
          if (_isLoading)
            Center(
              child: Image.asset(
                'assets/images/loading_capoo.gif',
                width: 200.0,
                height: 200.0,
              ),
            ),
        ],
      ),
    );
  }
}
