class AdminOrderDetailsModel {
  final int orderId;
  final String status;
  final Customer customer;
  final List<Product> products;
  final double totalAfterDiscount;

  AdminOrderDetailsModel({
    required this.orderId,
    required this.status,
    required this.customer,
    required this.products,
    required this.totalAfterDiscount,
  });

  factory AdminOrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return AdminOrderDetailsModel(
      orderId: json['orderId'],
      status: json['status'],
      customer: Customer.fromJson(json['customer']),
      products: List<Product>.from(
          json['products'].map((p) => Product.fromJson(p))),
      totalAfterDiscount: json['totalAfterDiscount'].toDouble(),
    );
  }
}

class Customer {
  final String fullName;
  final String phone;
  final String address;

  Customer({
    required this.fullName,
    required this.phone,
    required this.address,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
  return Customer(
    fullName: json['fullName'] ?? 'Unknown',
    phone: json['phone'] ?? 'N/A',
    address: json['address'] ?? 'No address',
  );
  }
}

class Product {
  final String name;
  final int quantity;
  final String imageUrl;

  Product({
    required this.name,
    required this.quantity,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
      return Product(
    name: json['name'] ?? 'Unnamed Product',
    quantity: json['quantity'] ?? 0,
    imageUrl: json['imageUrl'] ?? '',
  );
  }
}
