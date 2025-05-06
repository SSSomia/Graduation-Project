import 'package:flutter/material.dart';
import 'package:graduation_project/models/cart_model.dart';
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
      _cart = null;
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool isCartItemExist(CartItem product) {
    //  print(_cart!.cartItems.any((item) => item.productId == product.productId));
    return _cart!.cartItems.any((item) => item.productId == product.productId);
  }

  void addToCart(CartItem product, String token) async {
    // Show loading spinner while API request is in progress
    _isLoading = true;
    if (cart == null) {
      _cart = Cart(cartItems: [], totalCartPrice: 0);
    }

    // Call the API to add the item to the cart
    final success = await ApiService.addProductToCart(product.productId, token);

    if (success) {
      // After successful API call, update the local cart state
      cart!.cartItems.add(CartItem(
          productId: product.productId,
          productName: product.productName,
          price: product.price,
          quantity: product.quantity,
          totalPrice: product.totalPrice,
          imageUrl: product.imageUrl));
      // Recalculate total price
      cart!.totalCartPrice =
          cart!.cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
    } else {
      // Handle API failure (e.g., show an error message)
      print('Failed to add item to cart.');
    }

    // Hide loading spinner
    _isLoading = false;
    notifyListeners(); // Notify listeners to update the UI
  }

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

  void clearCartLocally() {
    if (_cart != null) {
      _cart!.cartItems.clear();
      _cart!.totalCartPrice = 0.0;
      notifyListeners();
    }
  }
}
