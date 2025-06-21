
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
      final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
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
        const SnackBar(content: Text("Updated successfully")),
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
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        title: const Text("Update Product"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel("Product Name"),
              _buildTextField(_nameController, "Product Name", Icons.abc_outlined),
              const SizedBox(height: 16),

              _buildLabel("Price"),
              _buildTextField(_priceController, "Price", Icons.attach_money_outlined,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 16),

              _buildLabel("Category"),
              Consumer<CategoryProvider>(
                builder: (context, provider, child) {
                  return DropdownButtonFormField<Category>(
                    decoration: _inputStyle().copyWith(
                      prefixIcon: const Icon(Icons.category_outlined),
                    ),
                    value: selectedCategory,
                    isExpanded: true,
                    items: provider.categories.map((cat) {
                      return DropdownMenuItem<Category>(
                        value: cat,
                        child: Text(cat.name),
                      );
                    }).toList(),
                    onChanged: (cat) => setState(() => selectedCategory = cat),
                    validator: (value) =>
                        value == null ? 'Please select a category' : null,
                  );
                },
              ),
              const SizedBox(height: 16),

              _buildLabel("Description"),
              TextFormField(
                controller: _descriptionController,
                decoration: _inputStyle().copyWith(
                  prefixIcon: const Icon(Icons.description_outlined),
                ),
                maxLines: 3,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),

              _buildLabel("Stock Quantity"),
              _buildTextField(_stockController, "Stock Quantity",
                  Icons.inventory_2_outlined,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 24),

              _buildLabel("Current Images"),
              if (_existingImageUrls.isNotEmpty)
                _buildNetworkImageGrid(_existingImageUrls)
              else
                const Text("No images available", style: TextStyle(color: Colors.grey)),

              const SizedBox(height: 24),
              _buildLabel("New Images (optional)"),
              if (_images.isNotEmpty) _buildFileImageGrid(_images),

              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _pickImages,
                icon: const Icon(Icons.photo_library),
                label: const Text("Pick New Images"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _updateProduct,
                  icon: const Icon(Icons.check, color: Colors.white),
                  label: const Text("Update Product",
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.red[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Input decoration
  InputDecoration _inputStyle() {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      IconData icon, {TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: _inputStyle().copyWith(
        labelText: hint,
        prefixIcon: Icon(icon),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Required' : null,
    );
  }

  Widget _buildNetworkImageGrid(List<String> urls) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: urls.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(urls[index], fit: BoxFit.cover),
        );
      },
    );
  }

  Widget _buildFileImageGrid(List<File> files) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: files.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(files[index], fit: BoxFit.cover),
            ),
            Positioned(
              top: 2,
              right: 2,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _images.removeAt(index);
                  });
                },
                child: const CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.black54,
                  child: Icon(Icons.close, size: 16, color: Colors.white),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

