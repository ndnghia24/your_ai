import 'package:flutter/material.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/knowledgebase_screen.dart';
import 'package:your_ai/features/knowledged_bot/domain/assistant_usecase_factory.dart';
import 'package:your_ai/features/knowledged_bot/presentation/ui/widgets/item_knowledgebase.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/features/knowledged_bot/domain/usecases/assistant_usecases.dart';

class AssistantSettingPopup extends StatefulWidget { // Changed from StatelessWidget
  final String instructions;
  final String assistantId;
  final String description;
  final String assistantName;
  final ValueChanged<String> onUpdateInstructions;
  

  const AssistantSettingPopup({
    super.key,
    required this.assistantId,
    required this.description,
    required this.instructions,
    required this.assistantName,
    required this.onUpdateInstructions,
  });

  @override
  _AssistantSettingPopupState createState() => _AssistantSettingPopupState();
}

class _AssistantSettingPopupState extends State<AssistantSettingPopup> {
  late TextEditingController _controller;
  
  final AssistantUseCaseFactory _assistantUseCaseFactory =
      GetIt.I<AssistantUseCaseFactory>();

  @override
  void initState() {
    super.initState();
    print('Instructions: ${widget.instructions}');
    _controller = TextEditingController(text: widget.instructions); // Initialize controller
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose controller
    super.dispose();
  }
   void _updateInstructions() async {
    final result = await _assistantUseCaseFactory.updateAssistantUseCase().execute(
      assistantId: widget.assistantId,
      description: widget.description,
      assistantName: widget.assistantName,
      instructions: _controller.text,
    );

    if (result.isSuccess) {
      print('Instructions updated successfully');
    } else {
      print('Failed to update instructions');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(20.0), // Increased padding for better UI
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Assistant Settings',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22, // Increased font size
                    color: Colors.blueAccent, // Consistent color
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _updateInstructions();
                    Navigator.pop(context); // Close dialog
                  },
                  icon: Icon(Icons.close, color: Colors.grey[700]), // Styled icon
                ),
              ],
            ),
            SizedBox(height: 20), // Added spacing

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Persona & Prompt',
                style: TextStyle(
                  color: Colors.grey[600], // Light grey text color
                  fontWeight: FontWeight.bold,
                  fontSize: 16, // Consistent font size
                ),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100], // Light grey input background
                hintText:
                    'Design the bot\'s persona, features and workflows using natural language.',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: 3, // Increased input height to 3 lines
              onChanged: widget.onUpdateInstructions, // Update instructions via callback
              controller: _controller, // Use the initialized controller
            ),

            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Add Knowledge Base',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                // Handle create knowledge action
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KnowledgeBaseScreen()),
                );
              },
              icon: Icon(Icons.add),
              label: Text('Create Knowledge'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  KnowledgeBaseItem(
                    title: 'KB 01',
                    size: '526.00 Bytes',
                    date: '17/10/2024',
                    units: 1,
                    isRemovable: false,
                  ),
                  KnowledgeBaseItem(
                    title: 'Chat bot',
                    size: '132.00 Bytes',
                    date: '9/10/2024',
                    units: 1,
                    isRemovable: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}