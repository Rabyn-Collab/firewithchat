import 'package:flutter_projects_start/main.dart';
import 'package:flutter_projects_start/model/cart_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




final cartProvider = StateNotifierProvider<CartProvider, List<CartItem>>((ref) => CartProvider(ref.read(box2)));

class CartProvider extends StateNotifier<List<CartItem>>{
  CartProvider(super.state);








}