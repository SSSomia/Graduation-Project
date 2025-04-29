// import 'dart:collection';

// import 'package:flutter/material.dart';
// import 'package:graduation_project/models/product_module.dart';
// import 'package:intl/number_symbols_data.dart';

// class ProductList extends ChangeNotifier {
// Map<String, Product> productMap = {
//   "1": Product(
//       id: "1",
//       productName: "Apple iPhone 14",
//       imageUrl: [
//         "https://www.vectordesign.us/wp-content/uploads/2021/12/Product-Photo-766x1024.webp",
//         "https://www.origins.com/media/export/cms/products/1000x1000/origins_sku_0T5W01_1000x1000_0.jpg"
//       ],
//       price: 999.99,
//       category: "Electronics",
//       stock: 10,
//       discription: "The latest iPhone with A16 Bionic chip and 48MP camera."),

//   "2": Product(
//       id: "2",
//       productName: "Samsung Galaxy S23",
//       imageUrl: [
//         "https://www.vectordesign.us/wp-content/uploads/2021/12/Product-Photo-766x1024.webp",
//         "https://www.origins.com/media/export/cms/products/1000x1000/origins_sku_0T5W01_1000x1000_0.jpg"
//       ],
//       price: 899.99,
//       category: "Electronics",
//       stock: 15,
//       discription:
//           "Powerful Snapdragon 8 Gen 2 processor with 120Hz AMOLED display."),

//   "3": Product(
//       id: "3",
//       productName: "Nike Air Max 270",
//       imageUrl: [
//         "https://www.vectordesign.us/wp-content/uploads/2021/12/Product-Photo-766x1024.webp",
//       ],
//       price: 149.99,
//       category: "Footwear",
//       stock: 25,
//       discription: "Comfortable and stylish sneakers with a large air unit."),

//   "4": Product(
//       id: "4",
//       productName: "Adidas Ultraboost",
//       imageUrl: [
//         "https://www.vectordesign.us/wp-content/uploads/2021/12/Product-Photo-766x1024.webp",
//         "https://www.origins.com/media/export/cms/products/1000x1000/origins_sku_0T5W01_1000x1000_0.jpg"
//       ],
//       price: 180.00,
//       category: "Footwear",
//       stock: 20,
//       discription: "High-performance running shoes with Boost cushioning."),

//   "5": Product(
//       id: "5",
//       productName: "Sony WH-1000XM5",
//       imageUrl: [
//         "https://www.vectordesign.us/wp-content/uploads/2021/12/Product-Photo-766x1024.webp",
//         "https://www.origins.com/media/export/cms/products/1000x1000/origins_sku_0T5W01_1000x1000_0.jpg"
//       ],
//       price: 399.99,
//       category: "Electronics",
//       stock: 8,
//       discription: "Industry-leading noise-canceling wireless headphones."),

//   "6": Product(
//       id: "6",
//       productName: "MacBook Pro 16\"",
//       imageUrl: [
//         "https://www.vectordesign.us/wp-content/uploads/2021/12/Product-Photo-766x1024.webp",
//         "https://www.origins.com/media/export/cms/products/1000x1000/origins_sku_0T5W01_1000x1000_0.jpg"
//       ],
//       price: 2499.99,
//       category: "Electronics",
//       stock: 5,
//       discription: "Powerful M2 Max chip with a stunning Retina display."),

//   "7": Product(
//       id: "7",
//       productName: "Canon EOS R6",
//       imageUrl: [
//         "https://www.vectordesign.us/wp-content/uploads/2021/12/Product-Photo-766x1024.webp",
//         "https://www.origins.com/media/export/cms/products/1000x1000/origins_sku_0T5W01_1000x1000_0.jpg"
//       ],
//       price: 2499.00,
//       category: "Cameras",
//       stock: 12,
//       discription: "Full-frame mirrorless camera with 4K video recording."),

//   "8": Product(
//       id: "8",
//       productName: "Logitech MX Master 3",
//       imageUrl: [
//         "https://www.vectordesign.us/wp-content/uploads/2021/12/Product-Photo-766x1024.webp",
//         "https://www.origins.com/media/export/cms/products/1000x1000/origins_sku_0T5W01_1000x1000_0.jpg"
//       ],
//       price: 99.99,
//       category: "Accessories",
//       stock: 30,
//       discription:
//           "Advanced ergonomic wireless mouse with customizable buttons."),

//   "9": Product(
//       id: "9",
//       productName: "Samsung 4K Smart TV",
//       imageUrl: [
//         "https://www.vectordesign.us/wp-content/uploads/2021/12/Product-Photo-766x1024.webp",
//         "https://www.origins.com/media/export/cms/products/1000x1000/origins_sku_0T5W01_1000x1000_0.jpg"
//       ],
//       price: 699.99,
//       category: "Electronics",
//       stock: 7,
//       discription:
//           "Ultra HD 4K Smart TV with vibrant colors and Dolby Audio."),

//   "10": Product(
//       id: "10",
//       productName: "Bose SoundLink Revolve+",
//       imageUrl: [
//         "https://www.vectordesign.us/wp-content/uploads/2021/12/Product-Photo-766x1024.webp",
//         "https://www.origins.com/media/export/cms/products/1000x1000/origins_sku_0T5W01_1000x1000_0.jpg"
//       ],
//       price: 199.99,
//       category: "Audio",
//       stock: 18,
//       discription: "Portable Bluetooth speaker with 360-degree sound."),
// };


//   void decreaseProductQuantityByOne(String procutID){
//     productMap[procutID]!.stock--;
//     notifyListeners();
//   }
//   void increaseProductQuantityByOne(String procutID){
//     productMap[procutID]!.stock++;
//     notifyListeners();
//   }
//   void increaseProductQuantity(String procutID, int quantity){
//     productMap[procutID]!.stock+= quantity;
//     notifyListeners();
//   }
//   void decreaseProductQuantity(String procutID, int quantity){
//     productMap[procutID]!.stock -= quantity;
//     notifyListeners();
//   }
// }
