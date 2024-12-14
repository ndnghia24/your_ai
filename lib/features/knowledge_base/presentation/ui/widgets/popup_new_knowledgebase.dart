import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/features/auth/presentation/ui/login_or_register_screen.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/blocs/kb_bloc.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/blocs/kb_event.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/blocs/kb_state.dart';

final getIt = GetIt.instance;

class CreateKnowledgeBaseDialog extends StatelessWidget {
  CreateKnowledgeBaseDialog({Key? key}) : super(key: key);

  // Define controllers
  final TextEditingController knowledgeNameController = TextEditingController();
  final TextEditingController knowledgeDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KBBloc, KBState>(
      bloc: getIt<KBBloc>(),
      builder: (context, state) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.storage, size: 64, color: Colors.orange),
                const SizedBox(height: 16),
                TextField(
                  controller: knowledgeNameController,
                  decoration: InputDecoration(
                    labelText: 'Knowledge name',
                    labelStyle: const TextStyle(color: Colors.red),
                    hintText: 'Enter knowledge name',
                    counterText: "0 / 50",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  maxLength: 50,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: knowledgeDescriptionController,
                  decoration: InputDecoration(
                    labelText: 'Knowledge description',
                    hintText: 'Enter knowledge description',
                    counterText: "0 / 2000",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  maxLines: 5,
                  maxLength: 2000,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (state is KBLoaded) {
                          context.read<KBBloc>().add(
                            CreateKBEvent(
                              knowledgeNameController.text,
                              knowledgeDescriptionController.text,
                              state.knowledgeBases,
                            ),
                          );
                          Navigator.of(context).pop();
                        } else {
                          // Optionally show an error message if state isn't KBLoaded
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Unable to create knowledge base.')),
                          );
                        }
                      },
                      child: const Text('Confirm'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
