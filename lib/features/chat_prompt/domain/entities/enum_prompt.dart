enum PromtCategory {
  business,
  other,
}

// enum to string
String getPromtCategoryString(PromtCategory category) {
  switch (category) {
    case PromtCategory.business:
      return 'business';
    case PromtCategory.other:
      return 'other';
    default:
      return 'other';
  }
}

// string to enum
PromtCategory getPromtCategory(String category) {
  switch (category) {
    case 'business':
      return PromtCategory.business;
    case 'other':
      return PromtCategory.other;
    default:
      return PromtCategory.other;
  }
}
