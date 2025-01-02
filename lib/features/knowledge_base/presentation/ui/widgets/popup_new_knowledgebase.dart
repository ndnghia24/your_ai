import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/core/theme/app_colors.dart';
import 'package:your_ai/features/knowledge_base/domain/entities/knowledge_model.dart';
import 'package:your_ai/features/knowledge_base/presentation/blocs/kb_bloc.dart';
import 'package:your_ai/features/knowledge_base/presentation/blocs/kb_event.dart';
import 'package:your_ai/features/knowledge_base/presentation/blocs/kb_state.dart';

final getIt = GetIt.instance;

class CreateKnowledgeBaseDialog extends StatefulWidget {
  final KnowledgeBase? knowledgeBase;
  CreateKnowledgeBaseDialog({Key? key, this.knowledgeBase}) : super(key: key);

  @override
  _CreateKnowledgeBaseDialogState createState() => _CreateKnowledgeBaseDialogState();
}

class _CreateKnowledgeBaseDialogState extends State<CreateKnowledgeBaseDialog> {
  final TextEditingController knowledgeNameController = TextEditingController();
  final TextEditingController knowledgeDescriptionController = TextEditingController();
  final ValueNotifier<bool> isButtonEnabled = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    if (widget.knowledgeBase != null) {
      knowledgeNameController.text = widget.knowledgeBase!.knowledgeName;
      knowledgeDescriptionController.text = widget.knowledgeBase!.description;
    }
    knowledgeNameController.addListener(_validate);
  }

  void _validate() {
    isButtonEnabled.value = knowledgeNameController.text.isNotEmpty;
  }

  void _updateKnowledgeBase(KnowledgeBase knowledgeBase) {
    final state = getIt<KBBloc>().state;
    if (state is KBLoaded) {
      getIt<KBBloc>().add(
        UpdateKBEvent(
          knowledgeBase.id,
          knowledgeNameController.text,
          knowledgeDescriptionController.text,
          state.knowledgeBases,
        ),
      );
    }
  }

  void _createKnowledgeBase() {
    final state = getIt<KBBloc>().state;
    if (state is KBLoaded) {
      getIt<KBBloc>().add(
        CreateKBEvent(
          knowledgeNameController.text,
          knowledgeDescriptionController.text,
          state.knowledgeBases,
        ),
      );
    }
  }

  @override
  void dispose() {
    knowledgeNameController.dispose();
    knowledgeDescriptionController.dispose();
    isButtonEnabled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KBBloc, KBState>(
      bloc: getIt<KBBloc>(),
      builder: (context, state) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
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
                      hintText: 'Enter knowledge name',
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
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey.shade400,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      ValueListenableBuilder<bool>(
                        valueListenable: isButtonEnabled,
                        builder: (context, isEnabled, child) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isEnabled ? AppColors.primary : Colors.grey.shade400,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: isEnabled
                                ? () {
                                    if (widget.knowledgeBase != null) {
                                      _updateKnowledgeBase(widget.knowledgeBase!);
                                    } else {
                                      _createKnowledgeBase();
                                    }
                                    Navigator.of(context).pop(knowledgeNameController.text);
                                  }
                                : null,
                            child: const Text('Create', style: TextStyle(color: Colors.white)),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
