import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/blocs/kb_bloc.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/blocs/kb_event.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/blocs/kb_state.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/widgets/item_knowledgebase.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/widgets/knowledgebase_detail_screen.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/widgets/popup_new_knowledgebase.dart';
import 'package:your_ai/features/knowledge_base/presentation/ui/widgets/widget_pagination.dart';
final getIt = GetIt.instance;
class KnowledgeBaseScreen extends StatelessWidget {
  const KnowledgeBaseScreen({super.key});

  void showNewKnowledgeDialog(BuildContext context) {
    // Show popup when click on "New" button
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateKnowledgeBaseDialog();
      },
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KBBloc, KBState>(
      bloc: getIt<KBBloc>(),
      builder: (context, KBState) {
        if (KBState is KBInitial) {
          getIt<KBBloc>().add(GetAllKBEvent());
          
        }
        if(KBState is KBError) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Knowledge'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Center(
              child: Text(KBState.message),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Knowledge'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // Handle Create Knowledge
                  showNewKnowledgeDialog(context);
                },
              )
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),

              if (KBState is KBLoading)
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              if (KBState is KBLoaded)
                Expanded(
                  child: ListView.builder(
                    itemCount: KBState.knowledgeBases.length,
                    itemBuilder: (context, index) {
                      return KnowledgeBaseItem(
                        onTapItem: (knowledgeBase) {
                          // Handle click on item
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KnowledgeDetailScreen(knowledgeBase: knowledgeBase),
                            ),
                          );
                        },
                        knowledgeBase: KBState.knowledgeBases[index],
                        onDelete: (knowledgeBase) {
                          // Handle delete action
                          getIt<KBBloc>().add(DeleteKBEvent(knowledgeBase.id, KBState.knowledgeBases));
                        },
                      );
                    },
                  ),
                ),
              PaginationWidget(),
            ],
          ),
        );
      }
    );
  }
}
