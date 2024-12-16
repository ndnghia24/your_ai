import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/configs/service_locator.dart';
import 'package:your_ai/features/knowledge_base/data/data_sources/services/knowledge_auth_service.dart';
import 'package:your_ai/features/knowledge_base/domain/enums/upload_type.dart';
import 'package:your_ai/features/knowledge_base/domain/knowledge_usecase_factory.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/blocs/unit_bloc.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/blocs/unit_event.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/blocs/unit_state.dart';
final getIt = GetIt.instance;
class UploadFileScreen extends StatefulWidget {
  final String knowledgeId;
  const UploadFileScreen({super.key, required this.knowledgeId});

  @override
  _UploadFileScreenState createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  bool _isFileUploaded = false;
  PlatformFile? _selectedFile;
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

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // Handle the selected file
      setState(() {
        _selectedFile = result.files.single;
        _isFileUploaded = true;
      });
      print('File selected: ${_selectedFile!.name}');
    } else {
      // User canceled the picker
      print('File selection canceled.');
    }
  }

  void _connect() async {
    if (_selectedFile == null) {
      Fluttertoast.showToast(msg: 'No file selected');
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
        filePathOrUrl: _selectedFile!.path!,
        UploadType.localFile,
      );

      if (result.isSuccess) {
        Fluttertoast.showToast(msg: 'Upload successful');
        
        // Load lại danh sách unit
        getIt<UnitBloc>().add(GetAllUnitEvent(defautKnowledgeId));
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: 'Upload failed: ${result.message}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error during upload: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  IconData _getFileIcon(String? extension) {
    switch (extension) {
      case 'pdf':
        return CupertinoIcons.doc_text_fill;
      case 'doc':
      case 'docx':
        return CupertinoIcons.doc_text;
      case 'xls':
      case 'xlsx':
        return CupertinoIcons.table;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return CupertinoIcons.photo;
      case 'mp4':
      case 'avi':
        return CupertinoIcons.videocam;
      default:
        return CupertinoIcons.doc;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitBloc, UnitState>(
      bloc: getIt<UnitBloc>(),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Upload Local File'),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Upload local file:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: _isFileUploaded && _selectedFile != null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    _getFileIcon(_selectedFile!.extension),
                                    size: 50,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    'File Name: ${_selectedFile!.name}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'File Type: ${_selectedFile!.extension}',
                                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'File Size: ${(_selectedFile!.size / 1024).toStringAsFixed(2)} KB',
                                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    CupertinoIcons.cloud_upload,
                                    size: 50,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(height: 15),
                                  const Text(
                                    'Click the button below to upload a file',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Strictly prohibit from uploading company data or other banned files',
                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _pickFile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Upload File', style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: _isFileUploaded ? _connect : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isFileUploaded ? Colors.grey.shade700 : Colors.grey.shade400,
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
    );
  }
}