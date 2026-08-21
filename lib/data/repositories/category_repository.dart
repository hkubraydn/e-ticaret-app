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

  void deleteCategory(int id) {
    final productRepository = ProductRepository();

    //Bu kategoriye ait tüm ürünlerin kategori id lerini null yap.
    productRepository.nullifyProductsCategory(id);

    // Kategoriyi soft delete yap.
    final index = seedCategories.indexWhere((category) => category.id == id);
    if (index != -1) {
      seedCategories[index].isDeleted = true;
    }
  }
}
