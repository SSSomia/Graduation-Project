class CartItem {
  final int productId;
  final String productName;
  final double price;
   int quantity;
   double totalPrice;
  final String imageUrl;

  CartItem({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.totalPrice,
    required this.imageUrl,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      productName: json['productName'],
      price: json['price'],
      quantity: json['quantity'],
      totalPrice: json['totalPrice'],
      imageUrl: json['imageUrl'],
    );
  }
}

class Cart {
  final List<CartItem> cartItems;
   double totalCartPrice;

  Cart({
    required this.cartItems,
    required this.totalCartPrice,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    var items = (json['cartItems'] as List)
        .map((item) => CartItem.fromJson(item))
        .toList();

    return Cart(
      cartItems: items,
      totalCartPrice: json['totalCartPrice'],
    );
  }
}
