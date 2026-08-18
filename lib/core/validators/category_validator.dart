class CategoryValidator {
  String? validateCategoryTitle(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a category title";
    }
    if (value.length < 3) {
      return "Category title must be at least 3 characters long";
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return "Category title can only contain letters, numbers, and underscores";
    }
    return null;
  }

  String? validateCategoryDesc(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a category description";
    }
    if (value.length < 3) {
      return "Category description must be at least 3 characters long";
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return "Category description can only contain letters, numbers, and underscores";
    }
    return null;
  }
}
