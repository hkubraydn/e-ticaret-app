import 'package:flutter/material.dart';
import 'package:hello/data/models/product_model.dart';
import 'package:provider/provider.dart';
import '../../data/providers/product_provider.dart';
import '../../data/providers/category_provider.dart';
import '../products/product_add_page.dart';
import '../products/product_edit_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPage();
}

class _ProductListPage extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductAddPage()),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (provider.products.isEmpty) {
            return const Center(child: Text("No product found"));
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: provider.products.length,
            itemBuilder: (context, index) {
              final product = provider.products[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            product.productCategoryId == null
                                ? "No category"
                                : context
                                      .read<CategoryProvider>()
                                      .categories
                                      .firstWhere(
                                        (category) =>
                                            category.id ==
                                            product.productCategoryId,
                                      )
                                      .categoryName,
                          ),
                          if (product.productCategoryId == null)
                            TextButton(
                              onPressed: () {
                                int? selectedId;
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder: (context, setDialogState) {
                                        return AlertDialog(
                                          title: const Text(
                                            "Choose a category",
                                          ),
                                          content: DropdownButton<int?>(
                                            isExpanded: true,
                                            value: selectedId,
                                            hint: const Text(
                                              "Choose a category",
                                            ),
                                            items: context
                                                .read<CategoryProvider>()
                                                .categories
                                                .map((category) {
                                                  return DropdownMenuItem<int?>(
                                                    value: category.id,
                                                    child: Text(
                                                      category.categoryName,
                                                    ),
                                                  );
                                                })
                                                .toList(),
                                            onChanged: (value) {
                                              setDialogState(() {
                                                selectedId = value;
                                              });
                                            },
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                final updatedProduct =
                                                    ProductModel(
                                                      id: product.id,
                                                      name: product.name,
                                                      barcode: product.barcode,
                                                      productCategoryId:
                                                          selectedId,
                                                    );
                                                if (selectedId != null) {
                                                  product.productCategoryId =
                                                      selectedId;
                                                  context
                                                      .read<ProductProvider>()
                                                      .updateProduct(
                                                        updatedProduct,
                                                      );
                                                }

                                                Navigator.pop(context);
                                              },
                                              child: const Text("Add"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                );
                              },

                              child: Text("Add Category"),
                            ),
                        ],
                      ),

                      Text(product.barcode),

                      const SizedBox(height: 8),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: product.status
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          product.status ? "Active" : "Passive",
                          style: TextStyle(
                            color: product.status
                                ? Colors.green.shade700
                                : Colors.red.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductEditPage(product: product),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                        color: Colors.blue,
                      ),

                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Are you sure?"),
                                content: Text(
                                  "Are you sure you want to delete this product?",
                                ),
                                actionsAlignment: MainAxisAlignment.center,
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel"),
                                  ),

                                  const SizedBox(width: 24),

                                  ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<ProductProvider>()
                                          .deleteProduct(product.id);

                                      Navigator.pop(context);
                                    },
                                    child: Text("Delete"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
