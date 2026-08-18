import 'package:flutter/foundation.dart';
import '../models/product_model.dart';
import '../repositories/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepository repository;

  List<ProductModel> products = [];

  ProductProvider(this.repository) {
    products = repository.getProducts();
  }

  bool isProductUnique(String productName, int? id) {
    return repository.isUnique(productName, id);
  }

  void addProduct(ProductModel product) {
    repository.addProduct(product);
    products = repository.getProducts();
    notifyListeners();
  }

  void updateProduct(ProductModel updatedProduct) {
    repository.updateProduct(updatedProduct);
    products = repository.getProducts();
    notifyListeners();
  }

  void deleteProduct(int id) {
    repository.deleteProduct(id);
    products = repository.getProducts();
    notifyListeners();
  }
}
