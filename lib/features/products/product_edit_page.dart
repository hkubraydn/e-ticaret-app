import 'package:flutter/material.dart';
import '../../core/component/my_textfield.dart';
import '../../core/validators/product_validator.dart';
import '../../data/models/product_model.dart';
import '../../data/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:hello/data/providers/category_provider.dart';
import '../../data/providers/language_provider.dart';

class ProductEditPage extends StatefulWidget {
  final ProductModel product;

  const ProductEditPage({super.key, required this.product});

  @override
  State<ProductEditPage> createState() => _ProductEditPage();
}

class _ProductEditPage extends State<ProductEditPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _barcodeController;
  late bool status;
  late int? selectedCategoryId;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.product.name);
    _barcodeController = TextEditingController(text: widget.product.barcode);
    status = widget.product.status;
    selectedCategoryId = widget.product.productCategoryId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _barcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(languageProvider.translate('productEdit'))),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //Name
              MyTextfield(
                controller: _nameController,
                hintText: languageProvider.translate('productTitle'),
                obscureText: false,
                validator: ProductValidator().validateName,
              ),

              //Barcode
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
                      labelText: languageProvider.translate('productCategory'),
                    ),
                    // isExpanded: true,
                    items: [
                      DropdownMenuItem<int?>(
                        value: null,
                        child: Text(languageProvider.translate('noCategory')),
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

              //Status Switch
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
                  final productName = _nameController.text.trim();
                  final barcode = _barcodeController.text.trim();

                  if (!productProvider.isProductUnique(
                    barcode,
                    widget.product.id,
                  )) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          languageProvider.translate('productExists'),
                        ),
                      ),
                    );
                    return;
                  }

                  final updatedProduct = ProductModel(
                    id: widget.product.id,
                    name: productName,
                    barcode: barcode,
                    productCategoryId: selectedCategoryId,
                    status: status,
                  );

                  productProvider.updateProduct(updatedProduct);
                  Navigator.pop(context);
                },
                child: Text(languageProvider.translate('save')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
