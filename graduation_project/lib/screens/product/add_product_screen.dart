// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class AddProductScreen extends StatefulWidget {
//   @override
//   _AddProductScreenState createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddProductScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _priceController = TextEditingController();
//   final _categoryController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _stockController = TextEditingController();
//   List<File> _images = [];

//   Future<void> _pickImages() async {
//     final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();
//     if (pickedFiles != null && pickedFiles.isNotEmpty) {
//       setState(() {
//         _images = pickedFiles.map((file) => File(file.path)).toList();
//       });
//     }
//   }

//   void _addProduct() {
//     if (!_formKey.currentState!.validate() || _images.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please complete all fields and select images')),
//       );
//       return;
//     }

//     final newProduct = Product(
//       id: DateTime.now().toString(),
//       productName: _nameController.text,
//       price: double.parse(_priceController.text),
//       imageUrl: _images.map((img) => img.path).toList(),
//       category: _categoryController.text,
//       description: _descriptionController.text,
//       stock: int.parse(_stockController.text),
//     );

//     Provider.of<MarketProvider>(context, listen: false).addProduct(newProduct);
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final inputStyle = InputDecoration(
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//     );

//     return Scaffold(
//       appBar: AppBar(title: const Text("Add Product")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // Product Name
//               TextFormField(
//                 controller: _nameController,
//                 decoration: inputStyle.copyWith(
//                   labelText: "Product Name",
//                   prefixIcon: const Icon(Icons.shopping_bag),
//                 ),
//                 validator: (value) =>
//                     value == null || value.isEmpty ? 'Required' : null,
//               ),
//               const SizedBox(height: 16),

//               // Price
//               TextFormField(
//                 controller: _priceController,
//                 decoration: inputStyle.copyWith(
//                   labelText: "Price",
//                   prefixIcon: const Icon(Icons.attach_money),
//                 ),
//                 keyboardType: TextInputType.number,
//                 validator: (value) =>
//                     value == null || value.isEmpty ? 'Required' : null,
//               ),
//               const SizedBox(height: 16),

//               // Category
//               TextFormField(
//                 controller: _categoryController,
//                 decoration: inputStyle.copyWith(
//                   labelText: "Category",
//                   prefixIcon: const Icon(Icons.category),
//                 ),
//                 validator: (value) =>
//                     value == null || value.isEmpty ? 'Required' : null,
//               ),
//               const SizedBox(height: 16),

//               // Description
//               TextFormField(
//                 controller: _descriptionController,
//                 decoration: inputStyle.copyWith(
//                   labelText: "Description",
//                   prefixIcon: const Icon(Icons.description),
//                 ),
//                 maxLines: 3,
//                 validator: (value) =>
//                     value == null || value.isEmpty ? 'Required' : null,
//               ),
//               const SizedBox(height: 16),

//               // Stock
//               TextFormField(
//                 controller: _stockController,
//                 decoration: inputStyle.copyWith(
//                   labelText: "Stock Quantity",
//                   prefixIcon: const Icon(Icons.inventory),
//                 ),
//                 keyboardType: TextInputType.number,
//                 validator: (value) =>
//                     value == null || value.isEmpty ? 'Required' : null,
//               ),
//               const SizedBox(height: 24),

//               // Image Grid
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Product Images",
//                   style: Theme.of(context).textTheme.titleMedium,
//                 ),
//               ),
//               const SizedBox(height: 10),

//               SizedBox(
//                 height: 200,
//                 child: _images.isEmpty
//                     ? Container(
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey.shade400),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: const Text("No images selected"),
//                       )
//                     : GridView.builder(
//                         itemCount: _images.length,
//                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 3,
//                           crossAxisSpacing: 8,
//                           mainAxisSpacing: 8,
//                         ),
//                         itemBuilder: (context, index) {
//                           return ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: Image.file(_images[index], fit: BoxFit.cover),
//                           );
//                         },
//                       ),
//               ),
//               const SizedBox(height: 16),

//               // Pick Images Button
//               OutlinedButton.icon(
//                 onPressed: _pickImages,
//                 icon: const Icon(Icons.photo_library),
//                 label: const Text("Pick Images"),
//                 style: OutlinedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 24),

//               // Add Product Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton.icon(
//                   onPressed: _addProduct,
//                   icon: const Icon(Icons.check),
//                   label: const Text("Add Product"),
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     textStyle: const TextStyle(fontSize: 16),
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
