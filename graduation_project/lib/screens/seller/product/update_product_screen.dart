import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graduation_project/models/catigory_model.dart';
import 'package:graduation_project/models/product_module.dart';
import 'package:graduation_project/providers/category_provider.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/seller_product_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UpdateProductScreen extends StatefulWidget {
  final ProductModule product;

  const UpdateProductScreen({super.key, required this.product});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _stockController = TextEditingController();
  List<File> _images = [];
  List<String> _existingImageUrls = [];

  Category? selectedCategory;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categoryProvider =
          Provider.of<CategoryProvider>(context, listen: false);
      categoryProvider.loadCategories().then((_) {
        final product = widget.product;

        setState(() {
          _nameController.text = product.name;
          _priceController.text = product.price.toString();
          _descriptionController.text = product.description;
          _stockController.text = product.stockQuantity.toString();
          _existingImageUrls = List<String>.from(product.imageUrls ?? []);
          selectedCategory = categoryProvider.categories.firstWhere(
            (cat) => cat.id == product.categoryId,
            orElse: () => categoryProvider.categories.first,
          );
        });
      });
    });
  }

  Future<void> _pickImages() async {
    final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        _images = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  Future<void> _updateProduct() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = Provider.of<SellerProductProvider>(context, listen: false);
    final authProvider = Provider.of<LoginProvider>(context, listen: false);

    try {
      final result = await provider.updateProduct(
        token: authProvider.token,
        productId: widget.product.productId,
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        stockQuantity: int.parse(_stockController.text),
        categoryId: selectedCategory!.id,
        images: _images,
      );
      await provider.fetchMyProducts(authProvider.token);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("updated successfully")),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Update failed: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputStyle = InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Update Product")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: inputStyle.copyWith(
                    labelText: "Product Name",
                    prefixIcon: const Icon(Icons.abc_outlined)),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: inputStyle.copyWith(
                    labelText: "Price",
                    prefixIcon: const Icon(Icons.attach_money_outlined)),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              Consumer<CategoryProvider>(
                builder: (context, provider, child) {
                  return DropdownButtonFormField<Category>(
                    decoration: inputStyle.copyWith(
                        labelText: "Category",
                        prefixIcon: const Icon(Icons.category_outlined)),
                    value: selectedCategory,
                    isExpanded: true,
                    items: provider.categories.map((cat) {
                      return DropdownMenuItem<Category>(
                        value: cat,
                        child: Text(cat.name),
                      );
                    }).toList(),
                    onChanged: (cat) {
                      setState(() {
                        selectedCategory = cat;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Select a category' : null,
                  );
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: inputStyle.copyWith(
                    labelText: "Description",
                    prefixIcon: const Icon(Icons.description_outlined)),
                maxLines: 3,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _stockController,
                decoration: inputStyle.copyWith(
                    labelText: "Stock Quantity",
                    prefixIcon: const Icon(Icons.inventory_2_outlined)),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Update Images (optional)",
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              const SizedBox(height: 10),

              if (_existingImageUrls.isNotEmpty || _images.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_existingImageUrls.isNotEmpty) ...[
                      const Text("Current Images:"),
                      const SizedBox(height: 8),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _existingImageUrls.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) => ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(_existingImageUrls[index],
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    if (_images.isNotEmpty) ...[
                      const Text("New Images (will be uploaded):"),
                      const SizedBox(height: 8),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _images.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) => ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(_images[index], fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ],
                )
              else
                const Text("No images available"),

              // if (_images.isNotEmpty)
              //   GridView.builder(
              //     shrinkWrap: true,
              //     itemCount: _images.length,
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 3,
              //       crossAxisSpacing: 8,
              //       mainAxisSpacing: 8,
              //     ),
              //     itemBuilder: (context, index) => ClipRRect(
              //       borderRadius: BorderRadius.circular(8),
              //       child: Image.file(_images[index], fit: BoxFit.cover),
              //     ),
              //   )
              // else
              //   const Text("No new images selected"),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _pickImages,
                icon: const Icon(Icons.photo_library),
                label: const Text("Pick New Images"),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _updateProduct,
                  icon: const Icon(Icons.update),
                  label: const Text("Update Product"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
