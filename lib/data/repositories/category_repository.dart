import '../models/category_model.dart';
import '../seed/category_seed.dart';
import '../../data/repositories/product_repository.dart';

class CategoryRepository {
  List<CategoryModel> getCategories() {
    return seedCategories.where((category) => !category.isDeleted).toList();
  }

  /*CategoryModel? getCategoryById(int id) {
    for (var category in seedCategories) {
      if (category.id == id && !category.isDeleted) {
        return category;
      }
    }
    return null;
  }*/

  bool isUnique(String categoryName, int? id) {
    for (var category in seedCategories) {
      if (category.categoryName == categoryName &&
          !category.isDeleted &&
          category.id != id) {
        return false;
      }
    }
    return true;
  }

  void addCategory(CategoryModel category) {
    seedCategories.add(category);
  }

  void updateCategory(CategoryModel updatedCategory) {
    final index = seedCategories.indexWhere(
      (category) => category.id == updatedCategory.id,
    );

    if (index != -1) {
      seedCategories[index] = updatedCategory;
    }
  }

  bool deleteCategory(int id) {
    final productRepository = ProductRepository();

    if (productRepository.hasAnyProducts(id)) {
      return true;
    }

    final index = seedCategories.indexWhere((category) => category.id == id);
    if (index != -1) {
      seedCategories[index].isDeleted = true;
    }

    return false;
  }
}
