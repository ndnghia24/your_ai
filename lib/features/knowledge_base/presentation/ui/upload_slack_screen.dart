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

class UploadSlackScreen extends StatefulWidget {
  final String knowledgeId;
  const UploadSlackScreen({super.key, required this.knowledgeId});

  @override
  _UploadSlackScreenState createState() => _UploadSlackScreenState();
}

class _UploadSlackScreenState extends State<UploadSlackScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _workspaceController = TextEditingController();
  final TextEditingController _botTokenController = TextEditingController();
  final KnowledgeUseCaseFactory _useCaseFactory =
      locator<KnowledgeUseCaseFactory>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void _connect() async {
    final name = _nameController.text;
    final workspace = _workspaceController.text;
    final botToken = _botTokenController.text;

    if (name.isEmpty || workspace.isEmpty || botToken.isEmpty) {
      Fluttertoast.showToast(msg: 'All fields are required');
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
        UploadType.slackContent,
        unitName: name,
        slackWorkspace: workspace,
        slackBotToken: botToken,
      );

      if (result.isSuccess) {
        getIt<UnitBloc>().add(GetAllUnitEvent(widget.knowledgeId));
        Fluttertoast.showToast(msg: 'Upload successful');
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
            msg:
                'Cannot upload Slack content, please check your inputs or network connection');
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
        title: const Text('Slack'),
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
                  'Upload Slack Content:',
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
                  controller: _workspaceController,
                  decoration: InputDecoration(
                    labelText: 'Slack Workspace',
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
                  controller: _botTokenController,
                  decoration: InputDecoration(
                    labelText: 'Slack Bot Token',
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
