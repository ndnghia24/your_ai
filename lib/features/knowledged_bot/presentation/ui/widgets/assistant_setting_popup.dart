import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/knowledgebase_screen.dart';
import 'package:your_ai/features/knowledged_bot/domain/assistant_usecase_factory.dart';
import 'package:your_ai/features/knowledged_bot/presentation/blocs/kb_bloc.dart';
import 'package:your_ai/features/knowledged_bot/presentation/blocs/kb_event.dart';
import 'package:your_ai/features/knowledged_bot/presentation/blocs/kb_state.dart';
import 'package:your_ai/features/knowledged_bot/presentation/ui/widgets/item_knowledgebase.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/features/knowledged_bot/domain/usecases/assistant_usecases.dart';

class AssistantSettingScreen extends StatefulWidget { // Changed from StatelessWidget
  final String instructions;
  final String assistantId;
  final String description;
  final String assistantName;
  final ValueChanged<String> onUpdateInstructions;
  

  const AssistantSettingScreen({
    super.key,
    required this.assistantId,
    required this.description,
    required this.instructions,
    required this.assistantName,
    required this.onUpdateInstructions,
  });

  @override
  _AssistantSettingScreenState createState() => _AssistantSettingScreenState();
}

class _AssistantSettingScreenState extends State<AssistantSettingScreen> {
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
    _updateInstructions();
    _controller.dispose(); 
    // Dispose controller
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

  void _onAttachKB(String knowledgeId, BuildContext context) async {
    final state = context.read<KBBloc>().state;
    if (state is KBLoaded) {
      context.read<KBBloc>().add(AttachKBEvent(
        widget.assistantId,
        knowledgeId,
        state.knowledgeBases,
      ));
    }
  }

  void _onDetachKB(String knowledgeId, BuildContext context) async {
    final state = context.read<KBBloc>().state;
    if (state is KBLoaded) {
      context.read<KBBloc>().add(DetachKBEvent(
        widget.assistantId,
        knowledgeId,
        state.knowledgeBases,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: [
        BlocProvider<KBBloc>(
          create: (context) => KBBloc(getIt<AssistantUseCaseFactory>()),
        ),
      ],
      child: BlocBuilder<KBBloc, KBState>(
        builder: (context, state) {
          if(state is KBInitial) {
            context.read<KBBloc>().add(GetAllKBEvent( widget.assistantId));
          }
          return Scaffold(
            appBar: AppBar(
                  title: const Text('Bot Settings'),
                  
                ),
            body: Container(
              padding: EdgeInsets.all(20.0), // Increased padding for better UI
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
              
          
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
                  if(state is KBLoaded)
                   
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.knowledgeBases.length,
                      itemBuilder: (context, index) {
                        return KnowledgeBaseItem(
                          knowledge: state.knowledgeBases[index],
                          onAttach: (knowledge) {
                            _onAttachKB(knowledge.id, context);
                          },
                          onDetach: (knowledge) {
                            _onDetachKB(knowledge.id, context);
                          },
                        );
                      },
                      
                    ),
                  ),
                  if(state is KBLoading)
                   
                  Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}