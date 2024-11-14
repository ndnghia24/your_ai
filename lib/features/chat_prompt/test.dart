import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';

import 'domain/entities/prompt.dart';
import 'domain/prompt_usecase_factory.dart';

final locator = GetIt.instance;

class TestChatPromptScreen extends StatefulWidget {
  const TestChatPromptScreen({super.key});

  @override
  _TestChatPromptScreenState createState() => _TestChatPromptScreenState();
}

class _TestChatPromptScreenState extends State<TestChatPromptScreen> {
  final ChatPromptUseCaseFactory chatPromptUseCaseFactory =
      locator<ChatPromptUseCaseFactory>();

  Prompt currentPrompt = Prompt(
    id: 'Empty',
    title: 'Empty',
    description: 'Empty',
    content: 'Empty',
    language: 'Empty',
    category: 'other',
    isPublic: true,
    userName: 'Empty',
    isFavorite: false,
  );

  List<Prompt> promptList = [];

  void _updatePrompt(Prompt prompt) {
    setState(() {
      currentPrompt = prompt;
    });
  }

  void _updatePromptList(List<Prompt> prompts) {
    setState(() {
      promptList = prompts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display currentPrompt and promptList information
            Text('currentPrompt: ${currentPrompt.title}'),
            Text('promptList: ${promptList.length}'),
            const Divider(),

            ElevatedButton(
              onPressed: () async {
                final usecaseResult = await chatPromptUseCaseFactory
                    .createPublicPromptUsecase
                    .execute(
                  title: 'Test Prompt at ${DateTime.now()}',
                  description: 'Test Prompt Description',
                  content: 'Test Prompt Content',
                  category: 'other',
                  language: 'English',
                );

                if (usecaseResult.isSuccess) {
                  _updatePrompt(usecaseResult.result);
                }

                Fluttertoast.showToast(
                  msg: currentPrompt.toMapString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text('createPublicPromptUsecase'),
            ),

            ElevatedButton(
              onPressed: () async {
                final usecaseResult = await chatPromptUseCaseFactory
                    .getPublicPromptsUsecase
                    .execute();

                if (usecaseResult.isSuccess) {
                  _updatePromptList(usecaseResult.result);
                }

                String promptListStringData = '';
                for (var element in promptList) {
                  promptListStringData += element.toMapString() + '\n';
                }

                Fluttertoast.showToast(
                  msg: promptListStringData,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text('getPublicPromptsUsecase'),
            ),

            Divider(),

            ElevatedButton(
              onPressed: () async {
                final usecaseResult = await chatPromptUseCaseFactory
                    .createPrivatePromptUsecase
                    .execute(
                  title: 'Test Prompt at ${DateTime.now()}',
                  description: 'Test Prompt Description',
                  content: 'Test Prompt Content',
                );

                if (usecaseResult.isSuccess) {
                  _updatePrompt(usecaseResult.result);
                }

                Fluttertoast.showToast(
                  msg: currentPrompt.toMapString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text('createPrivatePromptUsecase'),
            ),

            ElevatedButton(
              onPressed: () async {
                final usecaseResult = await chatPromptUseCaseFactory
                    .getPrivatePromptsUsecase
                    .execute();

                if (usecaseResult.isSuccess) {
                  _updatePromptList(usecaseResult.result);
                }

                String promptListStringData = '';
                for (var element in promptList) {
                  promptListStringData += element.toMapString() + '\n';
                }

                Fluttertoast.showToast(
                  msg: promptListStringData,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text('getPrivatePromptsUsecase'),
            ),

            ElevatedButton(
              onPressed: () async {
                final usecaseResult = await chatPromptUseCaseFactory
                    .updatePrivatePromptUsecase
                    .execute(
                  promptId: currentPrompt.id,
                  title: 'Test Prompt Updated',
                  description: 'Test Prompt Description Updated',
                  content: 'Test Prompt Content Updated',
                  category: 'other',
                  language: 'English',
                  isPublic: true,
                );

                if (usecaseResult.isSuccess) {
                  _updatePrompt(usecaseResult.result);
                }

                Fluttertoast.showToast(
                  msg: currentPrompt.toMapString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text('updatePrivatePromptUsecase'),
            ),

            ElevatedButton(
              onPressed: () async {
                final usecaseResult = await chatPromptUseCaseFactory
                    .deletePrivatePromptUsecase
                    .execute(
                  promptId: currentPrompt.id,
                );

                if (usecaseResult.isSuccess) {
                  _updatePrompt(Prompt.initial());
                }

                Fluttertoast.showToast(
                  msg: currentPrompt.toMapString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text('deletePrivatePromptUsecase'),
            ),

            Divider(),

            ElevatedButton(
              onPressed: () async {
                if (promptList.isEmpty) return;

                final usecaseResult = await chatPromptUseCaseFactory
                    .addFavouritePromptUsecase
                    .execute(
                  promptId: promptList[0].id,
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
              child: const Text('addFavouritePromptUsecase'),
            ),

            ElevatedButton(
              onPressed: () async {
                if (promptList.isEmpty) return;

                final usecaseResult = await chatPromptUseCaseFactory
                    .deletePrivatePromptUsecase
                    .execute(
                  promptId: promptList[0].id,
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
              child: const Text('deletePrivatePromptUsecase'),
            ),
          ],
        ),
      ),
    );
  }
}
