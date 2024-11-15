import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadFileScreen extends StatefulWidget {
  const UploadFileScreen({super.key});

  @override
  _UploadFileScreenState createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  bool _isFileUploaded = false;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // Handle the selected file
      print('File selected: ${result.files.single.name}');
      setState(() {
        _isFileUploaded = true;
      });
    } else {
      // User canceled the picker
      print('File selection canceled.');
    }
  }

  void _connect() {
    // Handle the connect action
    print('Connect button pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Local File'),
        centerTitle: true,
      ),
      body: Padding(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.upload_file,
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
                      'Support for single or bulk upload. Strictly prohibit from uploading company data or other banned files',
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
                child: const Text('Upload File'),
              ),
              const SizedBox(width: 60),
              ElevatedButton(
                onPressed: _isFileUploaded ? _connect : null,
                child: const Text('Connect'),
              ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
