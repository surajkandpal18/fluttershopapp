import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    this.id,
    this.title,
    this.quantity,
    this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get itemTotal {
    var total = 0.0;
    _items.forEach((key, ctm) {
      total = total + ctm.price * ctm.quantity;
    });
    return total;
  }

  void addItem(String pId, double price, String title) {
    if (_items.containsKey(pId)) {
      _items.update(
          pId,
          (existingValue) => CartItem(
                id: DateTime.now().toString(),
                title: title,
                price: price,
                quantity: existingValue.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
          pId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                price: price,
                quantity: 1,
              ));
    }
    notifyListeners();
  }

  void removeItem(String pId) {
    if (items.containsKey(pId)) {
      _items.remove(pId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (existingCartItems) => CartItem(
          id: existingCartItems.id,
          quantity: existingCartItems.quantity - 1,
          price: existingCartItems.price,
          title: existingCartItems.title,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }
}
