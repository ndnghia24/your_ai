import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:your_ai/configs/service_locator.dart';
import 'package:your_ai/features/knowledge_base/data/data_sources/services/knowledge_auth_service.dart';
import 'package:your_ai/features/knowledge_base/domain/enums/upload_type.dart';
import 'package:your_ai/features/knowledge_base/domain/knowledge_usecase_factory.dart';

class UploadConfluenceScreen extends StatefulWidget {
  final String knowledgeId;
  const UploadConfluenceScreen({super.key, required this.knowledgeId});

  @override
  _UploadConfluenceScreenState createState() => _UploadConfluenceScreenState();
}

class _UploadConfluenceScreenState extends State<UploadConfluenceScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _wikiPageUrlController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _accessTokenController = TextEditingController();
  final KnowledgeAuthService _authService = KnowledgeAuthService();
  final KnowledgeUseCaseFactory _useCaseFactory = locator<KnowledgeUseCaseFactory>();
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

  void _connect() async {
    final name = _nameController.text;
    final wikiPageUrl = _wikiPageUrlController.text;
    final username = _usernameController.text;
    final accessToken = _accessTokenController.text;

    if (name.isEmpty || wikiPageUrl.isEmpty || username.isEmpty || accessToken.isEmpty) {
      Fluttertoast.showToast(msg: 'All fields are required');
      return;
    }

    // Ẩn bàn phím
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await _useCaseFactory.uploadKnowledgeDataSourceUseCase.execute(
        widget.knowledgeId,
        _authService.accessToken!,
        UploadType.confluenceContent,
        unitName: name,
        wikiPageUrl: wikiPageUrl,
        confluenceUsername: username,
        confluenceAccessToken: accessToken,
      );

      if (result.isSuccess) {
        Fluttertoast.showToast(msg: 'Upload successful');
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: 'Cannot upload Confluence content, please check your inputs or network connection');
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
        title: const Text('Confluence'),
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
                  'Upload Confluence Content:',
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
                  controller: _wikiPageUrlController,
                  decoration: InputDecoration(
                    labelText: 'Wiki Page URL',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Confluence Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _accessTokenController,
                  decoration: InputDecoration(
                    labelText: 'Confluence Access Token',
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