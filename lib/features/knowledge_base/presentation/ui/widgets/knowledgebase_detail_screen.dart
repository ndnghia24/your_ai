import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/features/knowledge_base/domain/entities/knowledge_model.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/blocs/unit_bloc.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/blocs/unit_event.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/blocs/unit_state.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/widgets/popup_add_unit.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/widgets/popup_new_knowledgebase.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/widgets/unit_knowledgebase.dart';
final getIt = GetIt.instance;
class KnowledgeDetailScreen extends StatefulWidget {
  final KnowledgeBase knowledgeBase;
  const KnowledgeDetailScreen({super.key, required this.knowledgeBase});

  @override
  State<KnowledgeDetailScreen> createState() => _KnowledgeDetailScreenState();
}

class _KnowledgeDetailScreenState extends State<KnowledgeDetailScreen> {
  String knowledgeName = '';
  String knowledgeDescription = '';
  void showAddUnitDialog(BuildContext context) {
    // Show popup when click on "Add unit" button
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddUnitPopup(knowledgeBaseId: widget.knowledgeBase.id,);
      },
    );
  }

  void showUpdateKnowledgeDialog(BuildContext context, KnowledgeBase knowledgeBase) async {
    // Show popup when click on "Update" button
    var result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateKnowledgeBaseDialog(knowledgeBase: knowledgeBase);
      },
    );
  
    if (result != null) {
      if (result is String) {
        setState(() {
          knowledgeName = result;
        });
      } 
    }
    
  }

  @override
  void initState() {
    super.initState();
    knowledgeName = widget.knowledgeBase.knowledgeName;
    knowledgeDescription = widget.knowledgeBase.description;
    
    
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitBloc, UnitState>(
      bloc: getIt<UnitBloc>(),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Chat bot'),
           
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.storage, size: 40, color: Colors.orange),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Row(
                        children: [
                        Text(
                          knowledgeName,
                          style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                          // Handle edit action
                          showUpdateKnowledgeDialog(context, widget.knowledgeBase);
                          },
                        ),
                        ],
                      ),
                      Text(
                        '2 Units - 658.00 Bytes',
                        style: TextStyle(color: Colors.red),
                      ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        // Handle Add unit
                        showAddUnitDialog(context);
                      },
                      icon: Icon(Icons.add),
                      label: Text(
                        'Add unit', 
                        style: TextStyle(color: Colors.white),
                        ),
                    ),
                  ],
                ),
              ),
              if(state is UnitLoading) CircularProgressIndicator(),

              if(state is UnitLoaded)
              Expanded(
                child: ListView.builder(
                  itemCount: state.units.length,
                  itemBuilder: (context, index) {
                    return KnowledgeUnitItem(unit: state.units[index]);
                  },
                  
                  
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
