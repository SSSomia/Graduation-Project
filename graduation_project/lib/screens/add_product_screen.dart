import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/market_provider.dart';
import '../models/product.dart';
import 'dart:io';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  List<File> _images = [];

  Future<void> _pickImages() async {
    final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        _images = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  void _addProduct() {
    if (_nameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _categoryController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _stockController.text.isEmpty ||
        _images == null) {
      return;
    }

    final newProduct = Product(
      id: DateTime.now().toString(),
      productName: _nameController.text,
      price: double.parse(_priceController.text),
      imageUrl: _images.map((img) => img.path).toList(),
      category: _categoryController.text,
      description: _descriptionController.text,
      stock: int.parse(_stockController.text),
    );

    Provider.of<MarketProvider>(context, listen: false).addProduct(newProduct);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Product")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Product Name"),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: "Category"),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: "Description"),
                maxLines: 3,
              ),
              TextField(
                controller: _stockController,
                decoration: InputDecoration(labelText: "Stock Quantity"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: _images.isEmpty
                    ? Text("No Images Selected")
                    : GridView.builder(
                        itemCount: _images.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // Number of images per row
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                        itemBuilder: (context, index) {
                          return Image.file(_images[index], fit: BoxFit.cover);
                        },
                      ),
              ),
              ElevatedButton(
                onPressed: _pickImages,
                child: Text("Pick Image"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addProduct,
                child: Text("Add Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
