import 'package:flutter/foundation.dart';
import 'package:shop_app/providers/cart.dart';

class OrderItem with ChangeNotifier {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _ordersList = [];

  List<OrderItem> get orders {
    return [..._ordersList];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _ordersList.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          amount: total,
          dateTime: DateTime.now(),
          products: cartProducts,
        ));
  }
}
