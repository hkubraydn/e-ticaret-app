import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/component/my_textfield.dart';
import '../../core/validators/product_validator.dart';
// ignore: unused_import
import '../../data/models/product_model.dart';
// ignore: unused_import
import '../../data/providers/product_provider.dart';
import '../../data/providers/category_provider.dart';

class ProductAddPage extends StatefulWidget {
  const ProductAddPage({super.key});

  @override
  State<ProductAddPage> createState() => _ProductAddPage();
}

class _ProductAddPage extends State<ProductAddPage> {
  final _productController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool status = true;
  int? selectedCategoryId;

  @override
  void dispose() {
    _productController.dispose();
    _barcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Product")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                spacing: 20,
                children: [
                  //Name
                  MyTextfield(
                    controller: _productController,
                    hintText: "Product Name",
                    obscureText: false,
                    validator: ProductValidator().validateName,
                  ),

                  // barcode
                  MyTextfield(
                    controller: _barcodeController,
                    hintText: "Barcode",
                    obscureText: false,
                    validator: ProductValidator().validateBarcode,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      child: DropdownButtonFormField<int?>(
                        // ignore: deprecated_member_use
                        value: selectedCategoryId,
                        menuMaxHeight: 250,
                        decoration: const InputDecoration(
                          labelText: "Category",
                        ),
                        // isExpanded: true,
                        items: [
                          const DropdownMenuItem<int?>(
                            value: null,
                            child: Text("No Category"),
                          ),

                          ...context.watch<CategoryProvider>().categories.map((
                            category,
                          ) {
                            return DropdownMenuItem<int?>(
                              value: category.id,
                              child: Text(category.categoryName),
                            );
                          }),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedCategoryId = value;
                          });
                        },
                      ),
                    ),
                  ),

                  //status
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        const Text("Passive"),
                        Switch(
                          value: status,
                          onChanged: (value) {
                            setState(() {
                              status = value;
                            });
                          },
                        ),
                        const Text("Active"),
                      ],
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      final productProvider = context.read<ProductProvider>();
                      final productName = _productController.text.trim();
                      final barcode = _barcodeController.text.trim();

                      if (!productProvider.isProductUnique(barcode, null)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "A product with this barcode already exists.",
                            ),
                          ),
                        );
                        return;
                      }

                      final newProduct = ProductModel(
                        id: DateTime.now().millisecondsSinceEpoch,
                        name: productName,
                        barcode: barcode,
                        productCategoryId: selectedCategoryId,
                        status: status,
                      );

                      productProvider.addProduct(newProduct);

                      Navigator.pop(context);
                    },
                    child: Text("Add Product"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
