import 'package:flutter/foundation.dart';

class Order {
  final List<Map<String, dynamic>> orderItems;
  final int totalAmount;
  final String status; // e.g., 'Sudah Bayar'
  final DateTime date;

  Order({
    required this.orderItems,
    required this.totalAmount,
    required this.status,
    DateTime? date,
  }) : date = date ?? DateTime.now();
}

class OrderRepository extends ChangeNotifier {
  static final OrderRepository _instance = OrderRepository._internal();
  factory OrderRepository() => _instance;
  OrderRepository._internal();

  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders);

  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }
}
