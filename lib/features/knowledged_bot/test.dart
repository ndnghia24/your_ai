import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';

import 'domain/assistant_usecase_factory.dart';
import 'domain/entities/assistant_model.dart';
import 'domain/entities/thread_model.dart';

final locator = GetIt.instance;

class TestAssistantScreen extends StatefulWidget {
  const TestAssistantScreen({super.key});

  @override
  _TestAssistantScreenState createState() => _TestAssistantScreenState();
}

class _TestAssistantScreenState extends State<TestAssistantScreen> {
  final AssistantUseCaseFactory assistantUseCaseFactory =
      locator<AssistantUseCaseFactory>();

  Assistant currentAssistant = Assistant(
    id: 'Empty',
    name: 'Empty',
    description: 'Empty',
  );

  List<Assistant> assistantList = [];

  Thread currentThread = Thread.initial();

  List<Thread> threadList = [];

  void _updateAssistant(Assistant assistant) {
    setState(() {
      currentAssistant = assistant;
    });
  }

  void _updateAssistantList(List<Assistant> assistants) {
    setState(() {
      assistantList = assistants;
    });
  }

  void _updateThread(Thread thread) {
    setState(() {
      currentThread = thread;
    });
  }

  void _updateThreadList(List<Thread> threads) {
    setState(() {
      threadList = threads;
      currentThread = threads.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display currentAssistant and assistantList information
            Text('currentAssistant: ${currentAssistant.name}'),
            Text('assistantList: ${assistantList.length}'),

            // Display currentThread information
            Text('currentThread: ${currentThread.toMapString()}'),
            Text('threadList: ${threadList.length}'),
            const Divider(),

            ElevatedButton(
              onPressed: () async {
                final usecaseResult = await assistantUseCaseFactory
                    .createAssistantUseCase()
                    .execute(
                      assistantName: 'Test Assistant at ${DateTime.now()}',
                      description: 'Test Assistant Description',
                    );

                if (usecaseResult.isSuccess) {
                  _updateAssistant(usecaseResult.result);
                }

                Fluttertoast.showToast(
                  msg: currentAssistant.toMapString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text('createAssistantUseCase'),
            ),

            ElevatedButton(
              onPressed: () async {
                final usecaseResult = await assistantUseCaseFactory
                    .getAssistantsUseCase()
                    .execute();

                if (usecaseResult.isSuccess) {
                  _updateAssistantList(usecaseResult.result);
                }

                String assistantListStringData = '';
                for (var element in assistantList) {
                  assistantListStringData += element.toMapString() + '\n';
                }

                Fluttertoast.showToast(
                  msg: assistantListStringData,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text('getAssistantsUseCase'),
            ),

            ElevatedButton(
              onPressed: () async {
                final usecaseResult = await assistantUseCaseFactory
                    .updateAssistantUseCase()
                    .execute(
                      assistantId: currentAssistant.id,
                      assistantName: 'Updated Test Assistant',
                      description: 'Updated Test Assistant Description',
                    );

                if (usecaseResult.isSuccess) {
                  _updateAssistant(usecaseResult.result);
                }

                Fluttertoast.showToast(
                  msg: currentAssistant.toMapString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text('updateAssistantUseCase'),
            ),

            ElevatedButton(
              onPressed: () async {
                final usecaseResult = await assistantUseCaseFactory
                    .deleteAssistantUseCase()
                    .execute(
                      assistantId: currentAssistant.id,
                    );

                if (usecaseResult.isSuccess) {
                  _updateAssistant(Assistant.initial());
                }

                Fluttertoast.showToast(
                  msg: currentAssistant.toMapString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text('deleteAssistantUseCase'),
            ),

            Divider(),

            ElevatedButton(
              onPressed: () async {
                final usecaseResult = await assistantUseCaseFactory
                    .getAttachedKnowledgesUseCase()
                    .execute(
                      assistantId: currentAssistant.id,
                    );

                Fluttertoast.showToast(
                  msg: usecaseResult.result.length.toString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text('getAttachedKnowledgeUseCase'),
            ),

            ElevatedButton(
              onPressed: () async {
                final usecaseResult = await assistantUseCaseFactory
                    .attachKnowledgeUseCase()
                    .execute(
                      assistantId: currentAssistant.id,
                      knowledgeId: 'd71018a8-cae2-4ce3-9ab1-d9c2d7de3049',
                    );

                Fluttertoast.showToast(
                  msg: usecaseResult.result == true
                      ? 'Knowledge attached'
                      : 'Knowledge not attached',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text('attachKnowledgeUseCase'),
            ),

            ElevatedButton(
              onPressed: () async {
                final usecaseResult = await assistantUseCaseFactory
                    .detachKnowledgeUseCase()
                    .execute(
                      assistantId: currentAssistant.id,
                      knowledgeId: 'd71018a8-cae2-4ce3-9ab1-d9c2d7de3049',
                    );

                Fluttertoast.showToast(
                  msg: usecaseResult.result == true
                      ? 'Knowledge detached'
                      : 'Knowledge not detached',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text('detachKnowledgeUseCase'),
            ),

            Divider(),

            ElevatedButton(
              onPressed: () async {
                final usecaseResult =
                    await assistantUseCaseFactory.getThreadsUseCase().execute(
                          assistantId: currentAssistant.id,
                        );

                if (usecaseResult.isSuccess) {
                  _updateThreadList(usecaseResult.result);
                }

                Fluttertoast.showToast(
                  msg: usecaseResult.result.length.toString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text('getThreadsUseCase'),
            ),

            ElevatedButton(
              onPressed: () async {
                final usecaseResult = await assistantUseCaseFactory
                    .getThreadDetailsUseCase()
                    .execute(
                      currentThread: currentThread,
                      openAiThreadId: currentThread.openAiThreadId,
                    );

                if (usecaseResult.isSuccess) {
                  _updateThread(usecaseResult.result);
                }

                Fluttertoast.showToast(
                  msg: usecaseResult.result.messages.length.toString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text('getThreadDetailsUseCase'),
            ),

            ElevatedButton(
              onPressed: () async {
                final usecaseResult =
                    await assistantUseCaseFactory.createThreadUseCase().execute(
                          assistantId: currentAssistant.id,
                          threadName: 'Test Thread at ${DateTime.now()}',
                        );

                if (usecaseResult.isSuccess) {
                  _updateThread(usecaseResult.result);
                }

                Fluttertoast.showToast(
                  msg: currentThread.toMapString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text('createThreadUseCase'),
            ),

            ElevatedButton(
              onPressed: () async {
                final usecaseResult =
                    await assistantUseCaseFactory.continueChatUseCase().execute(
                          assistantId: currentAssistant.id,
                          openAiThreadId: currentThread.openAiThreadId,
                          message: 'Test Message',
                        );

                Fluttertoast.showToast(
                  msg: usecaseResult.result,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text('continueChatUseCase'),
            ),
          ],
        ),
      ),
    );
  }
}
