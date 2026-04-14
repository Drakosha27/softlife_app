import 'cart_item.dart';

class OrderModel {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final DateTime date;
  final String time;
  final String method; // Delivery or Pickup
  final String status;

  OrderModel({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.date,
    required this.time,
    required this.method,
    this.status = 'Scheduled',
  });
}
