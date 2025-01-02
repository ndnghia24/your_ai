enum PromptCategory {
  ALL,
  MARKETING,
  BUSINESS,
  SEO,
  WRITING,
  CODING,
  CAREER,
  CHATBOT,
  EDUCATION,
  FUN,
  PRODUCTIVITY,
  OTHER,
}

extension PromptCategoryExtension on PromptCategory {
  String get name {
    switch (this) {
      case PromptCategory.MARKETING:
        return 'marketing';
      case PromptCategory.BUSINESS:
        return 'business';
      case PromptCategory.SEO:
        return 'seo';
      case PromptCategory.WRITING:
        return 'writing';
      case PromptCategory.CODING:
        return 'coding';
      case PromptCategory.CAREER:
        return 'career';
      case PromptCategory.CHATBOT:
        return 'chatbot';
      case PromptCategory.EDUCATION:
        return 'education';
      case PromptCategory.FUN:
        return 'fun';
      case PromptCategory.PRODUCTIVITY:
        return 'productivity';
      case PromptCategory.OTHER:
        return 'other';
      case PromptCategory.ALL:
        return 'all';
    }
  }
}


const PROMPT_CATEGORY_ALL_OPTION = 'all';

const PROMPT_CATEGORY_ITEM = {
  PromptCategory.ALL: {
    'value': PromptCategory.ALL,
    'label': 'All',
  },
  PromptCategory.MARKETING: {
    'value': PromptCategory.MARKETING,
    'label': 'Marketing',
  },
  PromptCategory.BUSINESS: {
    'value': PromptCategory.BUSINESS,
    'label': 'Business',
  },
  PromptCategory.SEO: {
    'value': PromptCategory.SEO,
    'label': 'SEO',
  },
  PromptCategory.WRITING: {
    'value': PromptCategory.WRITING,
    'label': 'Writing',
  },
  PromptCategory.CODING: {
    'value': PromptCategory.CODING,
    'label': 'Coding',
  },
  PromptCategory.CAREER: {
    'value': PromptCategory.CAREER,
    'label': 'Career',
  },
  PromptCategory.CHATBOT: {
    'value': PromptCategory.CHATBOT,
    'label': 'Chatbot',
  },
  PromptCategory.EDUCATION: {
    'value': PromptCategory.EDUCATION,
    'label': 'Education',
  },
  PromptCategory.FUN: {
    'value': PromptCategory.FUN,
    'label': 'Fun',
  },
  PromptCategory.PRODUCTIVITY: {
    'value': PromptCategory.PRODUCTIVITY,
    'label': 'Productivity',
  },
  PromptCategory.OTHER: {
    'value': PromptCategory.OTHER,
    'label': 'Other',
  },
};

final PROMPT_CATEGORY_ITEMS = PROMPT_CATEGORY_ITEM.values.toList();

//PROMPT INPUT PARAM EXAMPLE: [any text]
final RegExp PROMPT_INPUT_PARAM_REGEX = RegExp(r'\[(.+?)\]');
