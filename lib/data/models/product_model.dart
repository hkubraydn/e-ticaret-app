class ProductModel {
  final int id;
  String name;
  int? productCategoryId;
  int barcode;
  bool status;
  bool isDeleted;

  ProductModel({
    required this.id,
    required this.name,
    this.productCategoryId,
    required this.barcode,
    this.status = true,
    this.isDeleted = false,
  });
}
