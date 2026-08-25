import 'package:flutter/material.dart';
import 'package:hello/core/component/my_textfield.dart';
import 'package:hello/core/validators/category_validator.dart';
import 'package:hello/data/models/category_model.dart';
import 'package:hello/data/providers/category_provider.dart';
import 'package:provider/provider.dart';
import '../../data/providers/language_provider.dart';

class CategoryEditPage extends StatefulWidget {
  final CategoryModel category;

  const CategoryEditPage({super.key, required this.category});

  @override
  State<CategoryEditPage> createState() => _CategoryEditPage();
}

class _CategoryEditPage extends State<CategoryEditPage> {
  late final TextEditingController _categoryController;
  late final TextEditingController _descriptionController;
  late bool status;

  @override
  void initState() {
    super.initState();

    _categoryController = TextEditingController(
      text: widget.category.categoryName,
    );
    _descriptionController = TextEditingController(
      text: widget.category.categoryDesc,
    );

    status = widget.category.status;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _categoryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text(languageProvider.translate('categoryEdit'))),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //title
              MyTextfield(
                controller: _categoryController,
                hintText: languageProvider.translate('categoryTitle'),
                obscureText: false,
                validator: CategoryValidator().validateCategoryTitle,
              ),

              //description
              MyTextfield(
                controller: _descriptionController,
                hintText: languageProvider.translate('categoryDesc'),
                obscureText: false,
                validator: CategoryValidator().validateCategoryDesc,
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
                  final categoryId = widget.category.id;
                  final categoryTitle = _categoryController.text.trim();
                  final categoryProvider = context.read<CategoryProvider>();

                  if (!categoryProvider.isCategoryUnique(
                    categoryTitle,
                    categoryId,
                  )) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          languageProvider.translate('categoryExists'),
                        ),
                      ),
                    );
                    return;
                  }

                  final updatedCategory = CategoryModel(
                    id: widget.category.id,
                    categoryName: categoryTitle,
                    categoryDesc: _descriptionController.text,
                    status: status,
                  );

                  context.read<CategoryProvider>().updateCategory(
                    updatedCategory,
                  );
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
