// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import '../../models/product.dart';
// import '../../providers/market_provider.dart';

// class EditProductScreen extends StatefulWidget {
//   final Product product;

//   const EditProductScreen({Key? key, required this.product}) : super(key: key);

//   @override
//   _EditProductScreenState createState() => _EditProductScreenState();
// }

// class _EditProductScreenState extends State<EditProductScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _priceController = TextEditingController();
//   final _categoryController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _stockController = TextEditingController();
//   List<File> _images = [];

//   final List<String> _categories = ['Electronics', 'Fashion', 'Home', 'Books'];

//   @override
//   void initState() {
//     super.initState();
//     _nameController.text = widget.product.productName;
//     _priceController.text = widget.product.price.toString();
//     _categoryController.text = widget.product.category;
//     _descriptionController.text = widget.product.description;
//     _stockController.text = widget.product.stock.toString();
//     _images = widget.product.imageUrl.map((path) => File(path)).toList();
//   }

//   Future<void> _pickImages() async {
//     final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();
//     if (pickedFiles != null) {
//       setState(() {
//         _images = pickedFiles.map((file) => File(file.path)).toList();
//       });
//     }
//   }

//   void _saveChanges() {
//     if (!_formKey.currentState!.validate() || _images.isEmpty) return;

//     final updatedProduct = Product(
//       id: widget.product.id,
//       productName: _nameController.text,
//       price: double.parse(_priceController.text),
//       category: _categoryController.text,
//       description: _descriptionController.text,
//       stock: int.parse(_stockController.text),
//       imageUrl: _images.map((img) => img.path).toList(),
//     );

//     Provider.of<MarketProvider>(context, listen: false).updateProduct(updatedProduct);
//     Navigator.pop(context);
//   }

//   void _deleteProduct() {
//     Provider.of<MarketProvider>(context, listen: false).deleteProduct(widget.product.id);
//     Navigator.pop(context); // Go back after deleting
//   }

//   InputDecoration _inputDecoration(String label, IconData icon) {
//     return InputDecoration(
//       labelText: label,
//       prefixIcon: Icon(icon),
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Edit Product")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // Product Name
//               TextFormField(
//                 controller: _nameController,
//                 decoration: _inputDecoration("Product Name", Icons.shopping_bag),
//                 validator: (value) => value!.isEmpty ? 'Required' : null,
//               ),
//               const SizedBox(height: 12),

//               // Price
//               TextFormField(
//                 controller: _priceController,
//                 keyboardType: TextInputType.number,
//                 decoration: _inputDecoration("Price", Icons.attach_money),
//                 validator: (value) => value!.isEmpty ? 'Required' : null,
//               ),
//               const SizedBox(height: 12),

//               // Category
//               DropdownButtonFormField<String>(
//                 decoration: _inputDecoration("Category", Icons.category),
//                 items: _categories
//                     .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
//                     .toList(),
//                 onChanged: (val) => _categoryController.text = val!,
//                 validator: (value) => value == null || value.isEmpty ? 'Required' : null,
//               ),
//               const SizedBox(height: 12),

//               // Description
//               TextFormField(
//                 controller: _descriptionController,
//                 maxLines: 3,
//                 decoration: _inputDecoration("Description", Icons.description),
//                 validator: (value) => value!.isEmpty ? 'Required' : null,
//               ),
//               const SizedBox(height: 12),

//               // Stock Quantity
//               TextFormField(
//                 controller: _stockController,
//                 keyboardType: TextInputType.number,
//                 decoration: _inputDecoration("Stock Quantity", Icons.storage),
//                 validator: (value) => value!.isEmpty ? 'Required' : null,
//               ),
//               const SizedBox(height: 20),

//               // Image Picker + Previews
//               if (_images.isNotEmpty) ...[
//                 SizedBox(
//                   height: 120,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: _images.length,
//                     itemBuilder: (context, index) => Stack(
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.only(right: 8),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: Image.file(
//                               _images[index],
//                               width: 100,
//                               height: 100,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           top: 2,
//                           right: 2,
//                           child: GestureDetector(
//                             onTap: () {
//                               setState(() => _images.removeAt(index));
//                             },
//                             child: const CircleAvatar(
//                               radius: 12,
//                               backgroundColor: Colors.red,
//                               child: Icon(
//                                 Icons.close,
//                                 size: 14,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//               ],
//               OutlinedButton.icon(
//                 onPressed: _pickImages,
//                 icon: const Icon(Icons.image),
//                 label: const Text("Change Images"),
//               ),
//               const SizedBox(height: 24),

//               // Save Changes Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton.icon(
//                   onPressed: _saveChanges,
//                   icon: const Icon(Icons.save),
//                   label: const Text("Save Changes"),
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 10),

//               // Delete Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton.icon(
//                   onPressed: _deleteProduct,
//                   icon: const Icon(Icons.delete),
//                   label: const Text("Delete Product"),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
