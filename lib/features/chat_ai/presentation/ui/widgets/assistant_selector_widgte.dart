import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/features/app/domain/entities/model_model.dart';
import 'package:your_ai/features/app/presentation/blocs/model_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/model_event.dart';
import 'package:your_ai/features/knowledged_bot/domain/entities/assistant_model.dart';
import 'package:your_ai/features/knowledged_bot/presentation/blocs/assistant_bloc.dart';
import 'package:your_ai/features/knowledged_bot/presentation/blocs/assistant_event.dart';
import 'package:your_ai/features/knowledged_bot/presentation/blocs/assistant_state.dart';

final getIt = GetIt.instance;

class AssistantSelector extends StatelessWidget {
  Assistant selectedAssistant;
  final Function(Assistant) onAssistantChanged;

  AssistantSelector({
    super.key,
    required this.selectedAssistant,
    required this.onAssistantChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssistantBloc, AssistantState>(
      bloc: getIt<AssistantBloc>()..add(GetAllAssistantEvent()),
      builder: (context, state) {
        if (state is AssistantLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AssistantLoaded) {
          if (state.assistants.isEmpty) {
            return Center(child: Text('No assistants available'));
          }
          if(!state.assistants.contains(selectedAssistant)){
            onAssistantChanged(state.assistants[0]);
            selectedAssistant = state.assistants[0];
          }
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
              child: DropdownButton<Assistant>(
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.grey.shade700,
                  size: 20,
                ),
                value: selectedAssistant,
                isDense: true,
                menuMaxHeight: 300,
                elevation: 8,
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(12),
                isExpanded: true,
                items: state.assistants.map((Assistant assistant) {
                  return DropdownMenuItem<Assistant>(
                    value: assistant,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.chat, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            assistant.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (Assistant? newValue) {
                  if (newValue != null) {
                    onAssistantChanged(newValue);
                  }
                },
              ),
            ),
          );
        } else if (state is AssistantError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Container();
      },
    );
  }
}