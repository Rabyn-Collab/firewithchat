

import 'package:flutter_projects_start/model/cart_item.dart';

class Order{

 final int total;
 final String DateTime;
 final List<CartItem> products;


 Order({
   required this.total,
   required this.products,
   required this.DateTime
});


 factory Order.fromJson(Map<String, dynamic> json){
   return Order(
       total: json['amount'],
       products: (json['products'] as List).map((e) => CartItem.fromJson(e)).toList(),
       DateTime: json['dateTime']
   );
 }


}