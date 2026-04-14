import 'dessert_item.dart';

class CartItem {
  final DessertItem dessert;
  int quantity;

  CartItem({
    required this.dessert,
    this.quantity = 1,
  });

  double get totalPrice => dessert.price * quantity;
}
