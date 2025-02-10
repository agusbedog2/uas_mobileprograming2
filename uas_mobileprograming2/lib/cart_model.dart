import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  get totalPrice => null;

  void addItem(Map<String, dynamic> item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  Future<void> checkout() async {
    final supabase = Supabase.instance.client;
    for (var item in _items) {
      await supabase.from('orders').insert({
        'product_id': item['id'],
        'quantity': 1,
      });
    }
    clearCart();
  }
}
