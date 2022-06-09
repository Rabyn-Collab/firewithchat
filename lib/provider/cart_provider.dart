import 'package:flutter_projects_start/main.dart';
import 'package:flutter_projects_start/model/cart_item.dart';
import 'package:flutter_projects_start/model/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';




final cartProvider = StateNotifierProvider<CartProvider, List<CartItem>>((ref) => CartProvider(ref.read(box2)));

class CartProvider extends StateNotifier<List<CartItem>>{
  CartProvider(super.state);

  String addProduct(Product product){
      if(state.isEmpty){
          final newCart = CartItem(
              id: product.id,
              title: product.product_name,
              price: product.price,
              imageUrl: product.image,
              quantity: 1,
              total: product.price
          );
          Hive.box<CartItem>('carts').add(newCart);
          state = [newCart];
        return 'success';
      }else{
         final item = state.firstWhere((element) => element.id == product.id, orElse: (){
          return CartItem(id: '', title: 'no-data', price: 0, imageUrl: '', quantity: 0, total: 0);
         });
         if(item.title == 'no-data'){
           final newCart = CartItem(
               id: product.id,
               title: product.product_name,
               price: product.price,
               imageUrl: product.image,
               quantity: 1,
               total: product.price
           );
           Hive.box<CartItem>('carts').add(newCart);
           state = [...state, newCart];
           return 'success';

         }else{
           return 'already added to cart';
         }

      }
  }



  void addSingleProduct(CartItem cartItem){
    cartItem.quantity = cartItem.quantity + 1;
    cartItem.total = cartItem.price * (cartItem.quantity + 1);
    cartItem.save();
     state = [
       for(final element in state)
         if(element == cartItem) cartItem else element
     ];

  }

  void removeSingleProduct(CartItem cartItem){
    if(cartItem.quantity > 1){
      cartItem.quantity = cartItem.quantity - 1;
      cartItem.total = cartItem.price * (cartItem.quantity - 1);
      cartItem.save();

      state = [
        for(final element in state)
          if(element == cartItem) cartItem else element
      ];
    }
  }


  void removeProduct(CartItem cartItem){
     cartItem.delete();
     final cart =state.firstWhere((element) => element.id == cartItem.id);
     state.remove(cart);
     state = [
       for(final element in state)
         if(element == cart) cart else element
     ];

  }


  int get total{
    int total = 0;
    state.forEach((element) {
      total += element.quantity * element.price;
    });
    return total;
  }



  void clearCartsItem(){
    Hive.box<CartItem>('carts').clear();
     state = [];
  }


}