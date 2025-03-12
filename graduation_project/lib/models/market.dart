import 'product.dart';

class Market {
  final String id;
  final String name;
  List<Product> products;

  Market({
    required this.id,
    required this.name,
    required this.products,
  });
}
