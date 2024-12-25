import 'package:flutter_svg/svg.dart';

enum GenerativeAiModel {
  gpt4o,
  gpt4oMini,
  gemini15Pro,
  gemini15Flash,
  claude3Haiku,
  claude3Sonnet,
  customChatBot,
}

const String dify = 'dify';

class GenerativeAiAssistant {
  final String id;
  final String model;
  final String name;
  final SvgPicture icon;

  const GenerativeAiAssistant({
    required this.id,
    required this.model,
    required this.name,
    required this.icon,
  });
}

final Map<GenerativeAiModel, GenerativeAiAssistant> generativeAiAssistants = {
  GenerativeAiModel.gpt4o: GenerativeAiAssistant(
    id: 'gpt-4o',
    model: dify,
    name: 'GPT-4o',
    icon: SvgPicture.asset('assets/svgs/gpt-4o.svg'), 
  ),
  GenerativeAiModel.gpt4oMini: GenerativeAiAssistant(
    id: 'gpt-4o-mini',
    model: dify,
    name: 'GPT-4o mini',
    icon: SvgPicture.asset('assets/svgs/gpt-4o-mini.svg'), 
  ),
  GenerativeAiModel.gemini15Pro: GenerativeAiAssistant(
    id: 'gemini-1.5-pro-latest',
    model: dify,
    name: 'Gemini 1.5 Pro',
    icon: SvgPicture.asset('assets/svgs/gemini-1.5-pro-latest.svg'),
  ),
  GenerativeAiModel.gemini15Flash: GenerativeAiAssistant(
    id: 'gemini-1.5-flash-latest',
    model: dify,
    name: 'Gemini 1.5 Flash',
    icon: SvgPicture.asset('assets/svgs/gemini-1.5-flash-latest.svg')
  ),
  GenerativeAiModel.claude3Haiku: GenerativeAiAssistant(
    id: 'claude-3-haiku-20240307',
    model: dify,
    name: 'Claude 3 Haiku',
    icon: SvgPicture.asset('assets/svgs/claude-3-haiku-20240307.svg'),
  ),
  GenerativeAiModel.claude3Sonnet: GenerativeAiAssistant(
    id: 'claude-3-sonnet-20240229',
    model: dify,
    name: 'Claude 3 Sonnet',
    icon: SvgPicture.asset('assets/svgs/claude-3-sonnet-20240229.svg'),
  ),
  GenerativeAiModel.customChatBot: GenerativeAiAssistant(
    id: 'custom-chatbot',
    model: dify,
    name: 'Custom Chatbot',
    icon: SvgPicture.asset('assets/svgs/claude-3-sonnet-20240229.svg'),
  ),
};


final Map<String, GenerativeAiModel> idToModelMap = {
  for (var entry in generativeAiAssistants.entries) entry.value.id: entry.key,
};

GenerativeAiAssistant? getAssistantById(String id) {
  final model = idToModelMap[id];
  if (model != null) {
    return generativeAiAssistants[model];
  }
  return null;
}

