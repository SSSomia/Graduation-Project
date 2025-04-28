import 'package:flutter/material.dart';
import 'package:graduation_project/api_models/cart_model.dart';
import 'package:graduation_project/services/api_service.dart';

class CartProvider with ChangeNotifier {
  Cart? _cart;
  bool _isLoading = false;

  Cart? get cart => _cart;
  bool get isLoading => _isLoading;

  Future<void> loadCart(String token) async {
    _isLoading = true;
    notifyListeners();

    try {
      _cart = await ApiService.fetchCart(token);
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

//   void updateQuantity(int productId, int newQuantity) {
//   final itemIndex = cart!.cartItems.indexWhere((item) => item.productId == productId);
//   if (itemIndex != -1) {
//     cart!.cartItems[itemIndex].quantity = newQuantity;

//     // Update the total price of that item
//     cart!.cartItems[itemIndex].totalPrice =
//         cart!.cartItems[itemIndex].price * newQuantity;

//     // Recalculate total cart price
//     cart!.totalCartPrice = cart!.cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

//     notifyListeners();
//   }
// }

  void updateQuantity(int productId, int newQuantity, String token) async {
    final itemIndex =
        cart!.cartItems.indexWhere((item) => item.productId == productId);

    if (itemIndex != -1) {
      // Save the current quantity to revert changes if the API call fails
      final previousQuantity = cart!.cartItems[itemIndex].quantity;

      // Temporarily update the local quantity and total price for UI responsiveness
      cart!.cartItems[itemIndex].quantity = newQuantity;
      cart!.cartItems[itemIndex].totalPrice =
          cart!.cartItems[itemIndex].price * newQuantity;
      cart!.totalCartPrice =
          cart!.cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

      notifyListeners();

      // Now, call the API to update the quantity on the backend
      final success =
          await ApiService.updateCartQuantity(productId, newQuantity, token);

      if (!success) {
        // If the API call fails, revert the changes locally
        cart!.cartItems[itemIndex].quantity = previousQuantity;
        cart!.cartItems[itemIndex].totalPrice =
            cart!.cartItems[itemIndex].price * previousQuantity;
        cart!.totalCartPrice =
            cart!.cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

        notifyListeners();

        // Optionally, show an error message or log the failure
        print('Failed to update cart item quantity on the server.');
      }
    }
  }

  void removeFromCart(int productId, String token) async {
    // Remove item from the local cart first for UI responsiveness
    final itemIndex =
        cart!.cartItems.indexWhere((item) => item.productId == productId);

    if (itemIndex != -1) {
      final removedItem = cart!.cartItems.removeAt(itemIndex);

      // Recalculate total cart price after removal
      cart!.totalCartPrice =
          cart!.cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

      notifyListeners();

      // Now, call the API to remove the item from the backend
      final success = await ApiService.removeCartItem(productId, token);

      if (!success) {
        // If the API call fails, add the item back to the cart and revert the total price
        cart!.cartItems.insert(itemIndex, removedItem);
        cart!.totalCartPrice =
            cart!.cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

        notifyListeners();

        // Optionally, show an error message or log the failure
        print('Failed to remove item from the cart on the server.');
      }
    }
  }
}
