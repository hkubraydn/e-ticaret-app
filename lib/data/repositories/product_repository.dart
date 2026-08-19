import '../models/product_model.dart';
import '../seed/product_seed.dart';

class ProductRepository {
  List<ProductModel> getProducts() {
    return seedProducts.where((product) => !product.isDeleted).toList();
  }

  bool isUnique(String barcode, int? id) {
    for (var product in seedProducts) {
      if (product.barcode == barcode &&
          !product.isDeleted &&
          product.id != id) {
        return false;
      }
    }
    return true;
  }

  void addProduct(ProductModel product) {
    seedProducts.add(product);
  }

  void updateProduct(ProductModel updatedProduct) {
    final index = seedProducts.indexWhere(
      (product) => product.id == updatedProduct.id,
    );

    if (index != -1) {
      seedProducts[index] = updatedProduct;
    }
  }

  void deleteProduct(int id) {
    final index = seedProducts.indexWhere((product) => product.id == id);

    if (index != -1) {
      seedProducts[index].isDeleted = true;
    }
  }
}
