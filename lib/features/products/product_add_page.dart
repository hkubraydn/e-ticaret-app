import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/component/my_textfield.dart';
import '../../core/validators/product_validator.dart';
// ignore: unused_import
import '../../data/models/product_model.dart';
// ignore: unused_import
import '../../data/providers/product_provider.dart';
import '../../data/providers/category_provider.dart';
import '../../data/providers/language_provider.dart';

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
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text(languageProvider.translate('productAdd'))),
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
                    hintText: languageProvider.translate('productTitle'),
                    obscureText: false,
                    validator: ProductValidator().validateName,
                  ),

                  // barcode
                  MyTextfield(
                    controller: _barcodeController,
                    hintText: languageProvider.translate('productBarcode'),
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
                        decoration: InputDecoration(
                          labelText: languageProvider.translate(
                            'productCategory',
                          ),
                        ),
                        // isExpanded: true,
                        items: [
                          DropdownMenuItem<int?>(
                            value: null,
                            child: Text(
                              languageProvider.translate('noCategory'),
                            ),
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
                        Text(languageProvider.translate('passive')),
                        Switch(
                          value: status,
                          onChanged: (value) {
                            setState(() {
                              status = value;
                            });
                          },
                        ),
                        Text(languageProvider.translate('active')),
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
                          SnackBar(
                            content: Text(
                              languageProvider.translate('productExists'),
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
                    child: Text(languageProvider.translate('productAdd')),
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
