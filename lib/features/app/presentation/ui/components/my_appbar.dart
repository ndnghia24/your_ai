import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/core/utils/ga4_service.dart';
import 'package:your_ai/core/theme/app_colors.dart';
import 'package:your_ai/core/utils/ga4_service.dart';
import 'package:your_ai/features/app/domain/entities/model_model.dart';
import 'package:your_ai/features/app/presentation/blocs/model_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/model_event.dart';
import 'package:your_ai/features/app/presentation/blocs/model_state.dart';
import 'package:your_ai/features/app/presentation/blocs/token_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/token_state.dart';
import 'package:your_ai/features/app/presentation/ui/widgets/model_selector_widget.dart';
import 'package:your_ai/features/chat_ai/presentation/ui/widgets/subscription_webview.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
//import 'dart:js' as js;

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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Image.asset('assets/images/ic_menu.png', height: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: BlocBuilder<ModelBloc, ModelState>(
              bloc: GetIt.I<ModelBloc>(),
              builder: (context, state) {
                if (state is ModelInitial) {
                  return ModelSelector(
                    selectedModel: state.selectedModel,
                    onModelChanged: (model) {
                      GetIt.I<GA4Service>()
                          .sendGA4Event(GA4EventNames.changeModel, {});
                      GetIt.I<ModelBloc>().add(UpdateModel(model));
                    },
                  );
                } else {
                  return ModelSelector(
                    selectedModel: GenerativeAiModel.gpt4oMini,
                    onModelChanged: (model) {
                      GetIt.I<GA4Service>()
                          .sendGA4Event(GA4EventNames.changeModel, {});
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
                    GetIt.I<GA4Service>()
                        .sendGA4Event(GA4EventNames.viewSubcription, {});
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
                      // js.context.callMethod('open', [
                      //   'https://admin.jarvis.cx/pricing/overview',
                      //   '_blank'
                      // ]);
                    }
                  },
                  style: TextButton.styleFrom(
                    // backgroundColor: Colors.grey.shade100,
                    backgroundColor: AppColors.surface,
                  ),
                  icon: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [Colors.red, Colors.yellow],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    child: Icon(
                      CupertinoIcons.flame,
                      color: Colors
                          .white, // This color will be masked by the gradient
                    ),
                  ),
                  label: Text(
                    '${state.remainingQuery == -1 ? '∞' : state.remainingQuery}',
                    style: TextStyle(
                      color: AppColors.onSecondary,
                      fontSize: 12,
                    ),
                  ),
                );
              } else {
                return TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.onPrimary,
                  ),
                  icon: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [Colors.red, Colors.yellow],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    child: Icon(
                      CupertinoIcons.flame,
                      color: Colors
                          .white, // This color will be masked by the gradient
                    ),
                  ),
                  label: Text(
                    '∞',
                    style: TextStyle(
                      color: AppColors.onSecondary,
                      fontSize: 12,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
