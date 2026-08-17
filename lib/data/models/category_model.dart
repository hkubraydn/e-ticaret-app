class CategoryModel {
  final int id;
  String categoryName;
  String categoryDesc;
  bool status;
  bool isDeleted;

  CategoryModel({
    required this.id,
    required this.categoryName,
    required this.categoryDesc,
    this.status = true,
    this.isDeleted = false,
  });
}
