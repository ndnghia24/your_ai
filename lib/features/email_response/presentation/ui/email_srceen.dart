import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async'; // Thêm thư viện Timer
import 'package:your_ai/features/email_response/presentation/ui/widgets/email_response_dialog.dart';
import '../../../../configs/service_locator.dart';
import '../../domain/email_usecase_factory.dart';
import '../logic_component/category_tree.dart';
import '../logic_component/tree_data_structure.dart';

class EmailResponseScreen extends StatefulWidget {
  @override
  _EmailResponseScreenState createState() => _EmailResponseScreenState();
}

class _EmailResponseScreenState extends State<EmailResponseScreen> {
  late CategoryTree categoryTree = CategoryTree();
  late List<TreeNode> lengthOptions;
  late List<TreeNode> formatOptions;
  late List<TreeNode> toneOptions;

  List<String> ideas = [];
  String selectedIdea = '';
  String activeTab = 'draft';
  String selectedLength = '';
  String selectedFormat = '';
  String selectedTone = '';
  String noteText = '';
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    categoryTree = CategoryTree();
    lengthOptions = categoryTree.lengthTree.children;
    formatOptions = categoryTree.fomalityTree.children;
    toneOptions = categoryTree.toneTree.children;

    selectedLength = categoryTree.lengthOptions;
    selectedFormat = categoryTree.formatOptions;
    selectedTone = categoryTree.toneOptions;
  }

  Future<void> _fetchIdeas() async {
    setState(() {
      ideas = [];
    });

    final usecaseResult = await locator<EmailResponseUseCaseFactory>()
        .getEmailReplyIdeasUseCase
        .execute(
      action: 'Suggest 3 ideas for this email',
      email: noteText,
      metadata: {
        "context": [],
        "subject": "”",
        "sender": "",
        "receiver": "",
        "language": "english",
      },
    );

    if (usecaseResult.isSuccess) {
      setState(() {
        ideas = usecaseResult.result;

        if (ideas.isNotEmpty) {
          selectedIdea = ideas[0];
        }
      });
    } else {
      print('Error: ${usecaseResult.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextInput(),
                        SizedBox(height: 24),
                        _buildIdeaSelection(),
                        _buildSection('Length', lengthOptions, (value) {
                          setState(() => selectedLength = value);
                        }, selectedLength),
                        SizedBox(height: 24),
                        _buildSection('Formality', formatOptions, (value) {
                          setState(() => selectedFormat = value);
                        }, selectedFormat),
                        SizedBox(height: 24),
                        _buildSection('Tone', toneOptions, (value) {
                          setState(() => selectedTone = value);
                        }, selectedTone),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // preprocess input
          if (noteText.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please enter email'),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.redAccent,
              ),
            );
            return;
          }

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return EmailResponseDialog(
                noteText: noteText,
                selectedLength: selectedLength,
                selectedFormat: selectedFormat,
                selectedTone: selectedTone,
                selectedIdea: selectedIdea,
              );
            },
          );
        },
        child: Icon(Icons.email),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 6,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildIdeaSelection() {
    if (noteText.isEmpty) {
      return SizedBox.shrink();
    }

    if (ideas.isEmpty) {
      return Center(
          child: Column(
        children: [
          CupertinoActivityIndicator(
            color: Colors.grey[50],
          ),
          SizedBox(height: 12),
          Text('Getting Ideas...'),
        ],
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select an Idea:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 12),
        Column(
          children: ideas.map((idea) {
            bool isActive = idea == selectedIdea;
            return Container(
              margin: EdgeInsets.only(bottom: 8),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedIdea = idea;
                  });
                },
                child: Text(idea),
                style: ElevatedButton.styleFrom(
                  foregroundColor: isActive ? Colors.white : Colors.grey[600],
                  backgroundColor: isActive
                      ? Theme.of(context).primaryColor
                      : Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 24), // Thêm SizedBox ở đây
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text(
            'Email AI',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          IconButton(
            icon: Icon(Icons.grid_view),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTextInput() {
    return Container(
      height: 200,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        maxLines: null,
        onChanged: (value) {
          setState(() {
            noteText = value;
          });

          if (_debounce?.isActive ?? false) _debounce?.cancel();
          _debounce = Timer(Duration(seconds: 2), _fetchIdeas);
        },
        decoration: InputDecoration(
          hintText: 'Write your email here...',
          hintStyle: TextStyle(color: Colors.grey[600]),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildSection(
    String title,
    List<TreeNode> options,
    Function(String) onOptionSelected,
    String selectedValue,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: options.map((option) {
              bool isActive = option.data == selectedValue;
              return Container(
                margin: EdgeInsets.only(right: 8),
                child: ElevatedButton(
                  onPressed: () => onOptionSelected(option.data),
                  child: Text(option.data),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: isActive ? Colors.white : Colors.grey[600],
                    backgroundColor: isActive
                        ? Theme.of(context).primaryColor
                        : Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
