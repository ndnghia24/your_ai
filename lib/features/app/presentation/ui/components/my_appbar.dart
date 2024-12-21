import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/features/app/domain/entities/model_model.dart';
import 'package:your_ai/features/app/presentation/blocs/model_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/model_event.dart';
import 'package:your_ai/features/app/presentation/blocs/model_state.dart';
import 'package:your_ai/features/app/presentation/blocs/token_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/token_state.dart';
import 'package:your_ai/features/app/presentation/ui/widgets/model_selector_widget.dart';
import 'package:your_ai/features/chat_ai/presentation/ui/widgets/subscription_webview.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:js' as js;

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    var screenColorScheme = Theme.of(context).colorScheme;

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Image.asset('assets/images/ic_menu.png', height: 24),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: BlocBuilder<ModelBloc, ModelState>(
              bloc: GetIt.I<ModelBloc>(),
              builder: (context, state) {
                if (state is ModelInitial) {
                  return ModelSelector(
                    selectedModel: state.selectedModel,
                    onModelChanged: (model) {
                      GetIt.I<ModelBloc>().add(UpdateModel(model));
                    },
                  );
                } else {
                  return ModelSelector(
                    selectedModel: GenerativeAiModel.gpt4oMini,
                    onModelChanged: (model) {
                      GetIt.I<ModelBloc>().add(UpdateModel(model));
                    },
                  );
                }
              },
            ),
          ),
          const SizedBox(width: 10),
          BlocBuilder<TokenBloc, TokenState>(
            builder: (context, state) {
              if (state is TokenLoaded) {
                return TextButton.icon(
                  onPressed: () {
                    // subscription active
                    if (!kIsWeb) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => SubscriptionWebView(
                          title: 'Subscription',
                          url: 'https://admin.jarvis.cx/pricing/overview',
                        ),
                      ));
                    } else {
                      // open website in new tab with new flutter
                      js.context.callMethod('open', [
                        'https://admin.jarvis.cx/pricing/overview',
                        '_blank'
                      ]);
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                  ),
                  icon: Icon(CupertinoIcons.flame,
                      color: screenColorScheme.secondary),
                  label: Text(
                    '${state.remainingQuery}',
                    style: TextStyle(
                      color: screenColorScheme.onSecondary,
                      fontSize: 12,
                    ),
                  ),
                );
              } else {
                return TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                  ),
                  icon: Icon(CupertinoIcons.flame,
                      color: screenColorScheme.secondary),
                  label: Text(
                    'N/A',
                    style: TextStyle(
                      color: screenColorScheme.onSecondary,
                      fontSize: 12,
                    ),
                  ),
                );
              }
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
