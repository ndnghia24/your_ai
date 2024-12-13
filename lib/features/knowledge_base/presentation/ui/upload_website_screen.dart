import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:your_ai/configs/service_locator.dart';
import 'package:your_ai/features/knowledge_base/data/data_sources/services/knowledge_auth_service.dart';
import 'package:your_ai/features/knowledge_base/domain/enums/upload_type.dart';
import 'package:your_ai/features/knowledge_base/domain/knowledge_usecase_factory.dart';

class UploadWebsiteScreen extends StatefulWidget {
  const UploadWebsiteScreen({super.key});

  @override
  _UploadWebsiteScreenState createState() => _UploadWebsiteScreenState();
}

class _UploadWebsiteScreenState extends State<UploadWebsiteScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _webUrlController = TextEditingController();
  final KnowledgeAuthService _authService = KnowledgeAuthService();
  final KnowledgeUseCaseFactory _useCaseFactory = locator<KnowledgeUseCaseFactory>();
  final defautKnowledgeId = '65003728-1738-42a5-b98e-a91113f45694';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _signIn();
  }

  Future<void> _signIn() async {
    try {
      final response = await _authService.signInWithEmailAndPassword(
        "anony24@gmail.com",
        "Anony24",
      );
      if (response.statusCode == 200) {
        print('Sign in successful');
      } else {
        print('Sign in failed');
      }
    } catch (e) {
      print('Error during sign in: $e');
    }
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
      final result = await _useCaseFactory.uploadKnowledgeDataSourceUseCase.execute(
        defautKnowledgeId,
        webUrl,
        _authService.accessToken!,
        UploadType.websiteContent,
        unitName: name,
        webUrl: webUrl,
      );

      if (result.isSuccess) {
        Fluttertoast.showToast(msg: 'Upload successful');
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: 'Cannot upload website content, your website may not be accessible or there is a network error'); 
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
                        backgroundColor: Colors.grey.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Connect', style: TextStyle(color: Colors.white)),
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