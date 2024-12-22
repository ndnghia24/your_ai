import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/assistant_model.dart';
import 'package:your_ai/features/knowledged_bot/presentation/blocs/assistant_bloc.dart';
import 'package:your_ai/features/knowledged_bot/presentation/blocs/assistant_event.dart';
import 'package:your_ai/features/knowledged_bot/presentation/blocs/assistant_state.dart';
final getIt = GetIt.instance;
class CreateAssistantDialog extends StatefulWidget {
  final Assistant? assistant;
  const CreateAssistantDialog({super.key, this.assistant});

  @override
  State<CreateAssistantDialog> createState() => _CreateAssistantDialogState();
}

class _CreateAssistantDialogState extends State<CreateAssistantDialog> {
  final TextEditingController assistantNameController = TextEditingController();
  final TextEditingController assistantDescriptionController = TextEditingController();
  final ValueNotifier<bool> isButtonEnabled = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    if (widget.assistant != null) {
      assistantNameController.text = widget.assistant!.name;
      assistantDescriptionController.text = widget.assistant!.description;
    }
    assistantNameController.addListener(_validate);
  }

  void _validate() {
    isButtonEnabled.value = assistantNameController.text.isNotEmpty;
  }

  void _updateAssistant(Assistant assistant) {
    final state = getIt<AssistantBloc>().state;
    if (state is AssistantLoaded) {
      getIt<AssistantBloc>().add(
        UpdateAssistantEvent(
          assistant.id,
          assistantNameController.text,
          assistantDescriptionController.text,
          state.assistants,
        ),
      );
    }
  }

  void _createAssistant() {
    final state = getIt<AssistantBloc>().state;
    if (state is AssistantLoaded) {
      getIt<AssistantBloc>().add(
        CreateAssistantEvent(
          assistantNameController.text,
          assistantDescriptionController.text,
          state.assistants,
        ),
      );
    }
  }

  @override
  void dispose() {
    assistantNameController.dispose();
    assistantDescriptionController.dispose();
    isButtonEnabled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssistantBloc, AssistantState>(
      bloc: getIt<AssistantBloc>(),
      builder: (context, state) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          insetPadding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Assistant',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Assistant name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: assistantNameController,
                  maxLength: 50,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter assistant name',
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Assistant description',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: assistantDescriptionController,
                  maxLines: 5,
                  maxLength: 2000,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter assistant description',
                  ),
                ),
               
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Cancel and close dialog
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: Text('Cancel'),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade700,
                      ),
                      onPressed: () {
                        if (widget.assistant != null) {
                          _updateAssistant(widget.assistant!);
                        } else {
                          _createAssistant();
                        }
                        // OK action, do something with form data
                        Navigator.of(context).pop();
                      },
                      child: Text(widget.assistant != null ? 'Update' : 'Create'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}