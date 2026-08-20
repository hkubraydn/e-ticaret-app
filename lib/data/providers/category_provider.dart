import 'package:flutter/foundation.dart';
import '../models/category_model.dart';
import '../repositories/category_repository.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryRepository repository;

  List<CategoryModel> categories = [];

  CategoryProvider(this.repository) {
    categories = repository.getCategories();
  }

  bool isCategoryUnique(String categoryName, int? id) {
    return repository.isUnique(categoryName, id);
  }

  void addCategory(CategoryModel category) {
    repository.addCategory(category);
    categories = repository.getCategories();
    notifyListeners();
  }

  void updateCategory(CategoryModel updatedCategory) {
    repository.updateCategory(updatedCategory);
    categories = repository.getCategories();
    notifyListeners();
  }

  bool deleteCategory(int id) {
    final result = repository.deleteCategory(id);
    if (!result) {
      categories = repository.getCategories();
      notifyListeners();
    }
    return result;
  }
}
