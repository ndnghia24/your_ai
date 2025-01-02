import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:your_ai/configs/service_locator.dart';
import 'package:your_ai/features/email_response/domain/email_usecase_factory.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailResponseDialog extends StatefulWidget {
  final String noteText;
  final String selectedLength;
  final String selectedFormat;
  final String selectedTone;
  final String selectedIdea;

  EmailResponseDialog({
    required this.noteText,
    required this.selectedLength,
    required this.selectedFormat,
    required this.selectedTone,
    required this.selectedIdea,
  });

  @override
  _EmailResponseDialogState createState() => _EmailResponseDialogState();
}

class _EmailResponseDialogState extends State<EmailResponseDialog> {
  bool isGenerating = false;
  String emailResponse = '';
  String selectedLanguage = 'vietnamese';

  Future<void> _generateEmail() async {
    setState(() {
      isGenerating = true;
    });

    final email = await locator<EmailResponseUseCaseFactory>()
        .getReplyByIdeaUseCase
        .execute(
      mainIdea: widget.selectedIdea,
      action: "Reply to this email",
      email: widget.noteText,
      metadata: {
        "context": [],
        "subject": "”",
        "sender": "",
        "receiver": "",
        "style": {
          "length": widget.selectedLength,
          "formality": widget.selectedFormat,
          "tone": widget.selectedTone,
        },
        "language": selectedLanguage
      },
    );

    setState(() {
      isGenerating = false;
      emailResponse = email.isSuccess
          ? email.result
          : 'Service cannot process at the moment';
    });
  }

  @override
  void initState() {
    super.initState();
    _generateEmail();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              isGenerating ? 'Generating Email Response...' : 'Email Response',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: isGenerating
          ? CupertinoActivityIndicator()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedLanguage,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedLanguage = newValue;
                              _generateEmail();
                            });
                          }
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.grey.shade700,
                          size: 20,
                        ),
                        isDense: true,
                        isExpanded: true,
                        elevation: 8,
                        menuMaxHeight: 300,
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        items: <String>[
                          'vietnamese',
                          'english',
                          'spanish',
                          'french'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 0.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.language,
                                    color: Colors.grey.shade700,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      value,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 14,
                                        height: 0.6,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(emailResponse, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
      actions: [
        if (!isGenerating)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: _generateEmail,
                icon: Icon(Icons.refresh),
                label: Text(''),
              ),
              TextButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: emailResponse));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Đã sao chép vào clipboard'),
                    backgroundColor: Colors.green,
                  ));
                },
                icon: Icon(Icons.copy),
                label: Text(''),
              ),
              TextButton.icon(
                onPressed: () async {
                  final mailtoUri = Uri(
                    scheme: 'mailto',
                    path: '',
                    query: {
                      'subject': Uri.encodeComponent('Your Subject Here'),
                      'body': Uri.encodeComponent(emailResponse),
                    }.entries.map((e) => '${e.key}=${e.value}').join('&'),
                  );

                  if (await canLaunchUrl(mailtoUri)) {
                    await launchUrl(mailtoUri);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Cannot open email client'),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                icon: Icon(Icons.email),
                label: Text(''),
              ),
            ],
          ),
      ],
    );
  }
}
