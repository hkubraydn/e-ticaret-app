import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/component/my_textfield.dart';
import '../../core/validators/category_validator.dart';
import '../../data/models/category_model.dart';
import '../../data/providers/category_provider.dart';

class CategoryAddPage extends StatefulWidget {
  const CategoryAddPage({super.key});

  @override
  State<CategoryAddPage> createState() => _CategoryAddPage();
}

class _CategoryAddPage extends State<CategoryAddPage> {
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool status = true;

  @override
  void dispose() {
    _categoryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Category")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  //Category title
                  MyTextfield(
                    controller: _categoryController,
                    hintText: "Category Title",
                    validator: CategoryValidator().validateCategoryTitle,
                    obscureText: false,
                  ),

                  //Category description
                  MyTextfield(
                    controller: _descriptionController,
                    hintText: "Description for category",
                    validator: CategoryValidator().validateCategoryDesc,
                    obscureText: false,
                  ),

                  //Status bar
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
                      final categoryTitle = _categoryController.text.trim();
                      final categoryProvider = context.read<CategoryProvider>();

                      if (!categoryProvider.isCategoryUnique(
                        categoryTitle,
                        null,
                      )) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("This category already exists."),
                          ),
                        );
                        return;
                      }

                      final newCategory = CategoryModel(
                        id: DateTime.now().millisecondsSinceEpoch,
                        categoryName: categoryTitle,
                        categoryDesc: _descriptionController.text,
                        status: status,
                      );

                      categoryProvider.addCategory(newCategory);

                      Navigator.pop(context);
                    },
                    child: Text("Add Category"),
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
