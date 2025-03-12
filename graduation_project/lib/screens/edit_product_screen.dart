import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/market_provider.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  EditProductScreen({required this.product});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _stockController = TextEditingController();
  List<File> _images = [];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.product.productName;
    _priceController.text = widget.product.price.toString();
    _categoryController.text = widget.product.category;
    _descriptionController.text = widget.product.description;
    _stockController.text = widget.product.stock.toString();
    _images = widget.product.imageUrl.map((path) => File(path)).toList();
  }

  Future<void> _pickImages() async {
    final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        _images = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  void _saveChanges() {
    if (_nameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _categoryController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _stockController.text.isEmpty ||
        _images.isEmpty) {
      return;
    }

    // Update product details
   final updatedProduct = Product(
    id: widget.product.id,
    productName: _nameController.text,
    price: double.parse(_priceController.text),
    category: _categoryController.text,
    description: _descriptionController.text,
    stock: int.parse(_stockController.text),
    imageUrl: _images.map((img) => img.path).toList(),
  );
    // Update the product in Provider
    Provider.of<MarketProvider>(context, listen: false)
        .updateProduct(updatedProduct);

    Navigator.pop(context);
  }

  void _deleteProduct() {
    Provider.of<MarketProvider>(context, listen: false)
        .deleteProduct(widget.product.id);
    Navigator.pop(context); // Go back after deleting
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Product")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
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
            _images.isEmpty
                ? Text("No Images Selected")
                : GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      return Image.file(_images[index], fit: BoxFit.cover);
                    },
                  ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImages,
              child: Text("Change Images"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text("Save Changes"),
            ),
            ElevatedButton(
              onPressed: _deleteProduct,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("Delete Product"),
            ),
          ],
        ),
      ),
    );
  }
}
