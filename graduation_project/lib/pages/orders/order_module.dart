import 'package:graduation_project/pages/cart/cart_list.dart';

class OrderModule {
  late String orderId;
  late CartList cartList;
  late DateTime dateTime;
  late String status;

   OrderModule({
    required this.orderId,
    required this.cartList,
    required this.dateTime,
    required this.status,
  });
}