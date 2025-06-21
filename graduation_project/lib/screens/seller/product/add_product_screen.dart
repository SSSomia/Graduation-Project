// import 'package:flutter/material.dart';
// import 'package:graduation_project/models/catigory_model.dart';
// import 'package:graduation_project/models/seller_product.dart';
// import 'package:graduation_project/providers/category_provider.dart';
// import 'package:graduation_project/providers/login_provider.dart';
// import 'package:graduation_project/providers/seller_product_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class AddProductScreen extends StatefulWidget {
//   @override
//   _AddProductScreenState createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddProductScreen> {
//   Category? selectedCategory;

//   @override
//   void initState() {
//     super.initState();
//     // Load categories once the widget is mounted
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<CategoryProvider>(context, listen: false).loadCategories();
//     });
//   }

//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _priceController = TextEditingController();
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

//   Future<void> _addProduct() async {
//     if (!_formKey.currentState!.validate() || _images.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text('Please complete all fields and select images')),
//       );
//       return;
//     }
//     final provider = Provider.of<SellerProductProvider>(context, listen: false);
//     final authProvider = Provider.of<LoginProvider>(context, listen: false);

//     final product = SellerProduct(
//       name: _nameController.text,
//       description: _descriptionController.text,
//       price: double.parse(_priceController.text),
//       stockQuantity: int.parse(_stockController.text),
//       categoryId: selectedCategory!.id,
//     );

//     try {
//       final result = await provider.addProduct(
//         token: authProvider.token,
//         product: product,
//         images: _images,
//       );

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(result['message'])),
//       );
//       Navigator.pop(context, true);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to add product: ${e.toString()}')),
//       );
//     }
//     Provider.of<SellerProductProvider>(context, listen: false)
//         .fetchMyProducts(authProvider.token);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final inputStyle = InputDecoration(
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//     );

//     return Scaffold(
//       appBar: AppBar(title: const Text("Add Product"), backgroundColor: const Color.fromARGB(255, 255, 248, 248),),
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
//                   prefixIcon: const Icon(Icons.abc_outlined),
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
//                   prefixIcon: const Icon(Icons.attach_money_outlined),
//                 ),
//                 keyboardType: TextInputType.number,
//                 validator: (value) =>
//                     value == null || value.isEmpty ? 'Required' : null,
//               ),
//               const SizedBox(height: 16),

//               // Category

//               Consumer<CategoryProvider>(builder: (context, provider, child) {
//                 if (provider.isLoading) {
//                   return const CircularProgressIndicator();
//                 }
//                 return DropdownButtonFormField<Category>(
//                   decoration: inputStyle.copyWith(
//                     labelText: "Category",
//                     prefixIcon: const Icon(Icons.category_outlined),
//                   ),
//                   value: selectedCategory,
//                   isExpanded: true,
//                   items: provider.categories.map((cat) {
//                     return DropdownMenuItem<Category>(
//                       value: cat,
//                       child: Text(cat.name),
//                     );
//                   }).toList(),
//                   onChanged: (Category? newCat) {
//                     setState(() {
//                       selectedCategory = newCat;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null) {
//                       return 'Please select a category';
//                     }
//                     return null;
//                   },
//                 );
//               }),
//               const SizedBox(height: 16),

//               // Description
//               TextFormField(
//                 controller: _descriptionController,
//                 decoration: inputStyle.copyWith(
//                   labelText: "Description",
//                   prefixIcon: const Icon(Icons.description_outlined),
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
//                   prefixIcon: const Icon(Icons.inventory_2_outlined),
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
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 3,
//                           crossAxisSpacing: 8,
//                           mainAxisSpacing: 8,
//                         ),
//                         itemBuilder: (context, index) {
//                           return ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child:
//                                 Image.file(_images[index], fit: BoxFit.cover),
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
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                  
//                   icon: const Icon(Icons.check,color: Colors.white),
//                   label: const Text("Add Product", style: TextStyle(color: Colors.white),),
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     backgroundColor: const Color.fromARGB(255, 185, 28, 28),
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


import 'package:flutter/material.dart';
import 'package:graduation_project/models/catigory_model.dart';
import 'package:graduation_project/models/seller_product.dart';
import 'package:graduation_project/providers/category_provider.dart';
import 'package:graduation_project/providers/login_provider.dart';
import 'package:graduation_project/providers/seller_product_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  Category? selectedCategory;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _stockController = TextEditingController();
  List<File> _images = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).loadCategories();
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
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add product: ${e.toString()}')),
      );
    }

    provider.fetchMyProducts(authProvider.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        title: const Text("Add Product"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
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
              _buildTextField(
                _priceController,
                "Price",
                Icons.attach_money_outlined,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              _buildLabel("Category"),
              Consumer<CategoryProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return DropdownButtonFormField<Category>(
                    decoration: _inputStyle().copyWith(
                        prefixIcon: const Icon(Icons.category_outlined)),
                    value: selectedCategory,
                    isExpanded: true,
                    items: provider.categories.map((cat) {
                      return DropdownMenuItem<Category>(
                        value: cat,
                        child: Text(cat.name),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => selectedCategory = val),
                    validator: (value) =>
                        value == null ? 'Please select a category' : null,
                  );
                },
              ),
              const SizedBox(height: 16),

              _buildLabel("Description"),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: _inputStyle().copyWith(
                  prefixIcon: const Icon(Icons.description_outlined),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),

              _buildLabel("Stock Quantity"),
              _buildTextField(
                _stockController,
                "Stock Quantity",
                Icons.inventory_2_outlined,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),

              _buildLabel("Product Images"),
              const SizedBox(height: 10),
              _buildImagePreviewGrid(),

              const SizedBox(height: 16),
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
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _addProduct,
                  icon: const Icon(Icons.check, color: Colors.white),
                  label: const Text("Add Product",
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: const Color.fromARGB(255, 175, 30, 30),
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

  InputDecoration _inputStyle() {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      IconData icon, {TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      decoration: _inputStyle().copyWith(
        labelText: hint,
        prefixIcon: Icon(icon),
      ),
      keyboardType: keyboardType,
      validator: (value) =>
          value == null || value.isEmpty ? 'Required' : null,
    );
  }

  Widget _buildImagePreviewGrid() {
    if (_images.isEmpty) {
      return Container(
        height: 150,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.image, size: 40, color: Colors.grey),
            SizedBox(height: 8),
            Text("No images selected", style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    } else {
      return SizedBox(
        height: 200,
        child: GridView.builder(
          itemCount: _images.length,
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
                  child: Image.file(
                    _images[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
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
        ),
      );
    }
  }
}
