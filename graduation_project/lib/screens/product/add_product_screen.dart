import 'package:flutter/material.dart';
import 'package:graduation_project/models/catigory_model.dart';
import 'package:graduation_project/models/seller_product.dart';
import 'package:graduation_project/providers/category_provider.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/seller_product_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  Category? selectedCategory;

  @override
  void initState() {
    super.initState();
    // Load categories once the widget is mounted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).loadCategories();
    });
  }

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _stockController = TextEditingController();
  List<File> _images = [];

  Future<void> _pickImages() async {
    final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        _images = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  Future<void> _addProduct() async {
    if (!_formKey.currentState!.validate() || _images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please complete all fields and select images')),
      );
      return;
    }
    final provider = Provider.of<SellerProductProvider>(context, listen: false);
    final authProvider = Provider.of<LoginProvider>(context, listen: false);

    final product = SellerProduct(
      name: _nameController.text,
      description: _descriptionController.text,
      price: double.parse(_priceController.text),
      stockQuantity: int.parse(_stockController.text),
      categoryId: selectedCategory!.id,
    );

    try {
      final result = await provider.addProduct(
        token: authProvider.token,
        product: product,
        images: _images,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'])),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add product: ${e.toString()}')),
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final inputStyle = InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Product Name
              TextFormField(
                controller: _nameController,
                decoration: inputStyle.copyWith(
                  labelText: "Product Name",
                  prefixIcon: const Icon(Icons.shopping_bag),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),

              // Price
              TextFormField(
                controller: _priceController,
                decoration: inputStyle.copyWith(
                  labelText: "Price",
                  prefixIcon: const Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),

              // Category

              Consumer<CategoryProvider>(builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const CircularProgressIndicator();
                }
                return DropdownButtonFormField<Category>(
                  decoration: inputStyle.copyWith(
                    labelText: "Category",
                    prefixIcon: const Icon(Icons.category),
                  ),
                  value: selectedCategory,
                  isExpanded: true,
                  items: provider.categories.map((cat) {
                    return DropdownMenuItem<Category>(
                      value: cat,
                      child: Text(cat.name),
                    );
                  }).toList(),
                  onChanged: (Category? newCat) {
                    setState(() {
                      selectedCategory = newCat;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                );
              }),
              //   return DropdownButton<Category>(
              //     hint: const Text('Select a category'),
              //     value: selectedCategory,
              //     isExpanded: true,
              //     items: provider.categories.map((cat) {
              //       return DropdownMenuItem<Category>(
              //         value: cat,
              //         child: Text(cat
              //             .name), // Assuming your Category model has a `name`
              //       );
              //     }).toList(),
              //     onChanged: (Category? newCat) {
              //       setState(() {
              //         selectedCategory = newCat;
              //       });
              //     },
              //   );
              // }),
              // TextFormField(
              //   controller: _categoryController,
              //   decoration: inputStyle.copyWith(
              //     labelText: "Category",
              //     prefixIcon: const Icon(Icons.category),
              //   ),
              //   validator: (value) =>
              //       value == null || value.isEmpty ? 'Required' : null,
              // ),
              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: inputStyle.copyWith(
                  labelText: "Description",
                  prefixIcon: const Icon(Icons.description),
                ),
                maxLines: 3,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),

              // Stock
              TextFormField(
                controller: _stockController,
                decoration: inputStyle.copyWith(
                  labelText: "Stock Quantity",
                  prefixIcon: const Icon(Icons.inventory),
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 24),

              // Image Grid
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Product Images",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 10),

              SizedBox(
                height: 200,
                child: _images.isEmpty
                    ? Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text("No images selected"),
                      )
                    : GridView.builder(
                        itemCount: _images.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child:
                                Image.file(_images[index], fit: BoxFit.cover),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 16),

              // Pick Images Button
              OutlinedButton.icon(
                onPressed: _pickImages,
                icon: const Icon(Icons.photo_library),
                label: const Text("Pick Images"),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Add Product Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _addProduct,
                  icon: const Icon(Icons.check),
                  label: const Text("Add Product"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
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
}
