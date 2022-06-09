import 'package:hive_flutter/adapters.dart';
part 'cart_item.g.dart';


@HiveType(typeId: 1)
class CartItem extends HiveObject{

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  String imageUrl;

  @HiveField(4)
  int price;

  @HiveField(5)
  int total;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.total
  });


  factory CartItem.fromJson(Map<String, dynamic> json){
    return CartItem(
        title: json['title'],
      imageUrl: json['imageUrl'],
      id: json['id'],
      price: json['price'],
      quantity: json['quantity'],
      total: json['total']
    );
  }


  Map<String, dynamic> toJson(){
    return {
      'title': this.title,
      'imageUrl': this.imageUrl,
      'id': this.id,
      'price': this.price,
      'quantity': this.quantity,
      'total': this.total
    };
  }


}