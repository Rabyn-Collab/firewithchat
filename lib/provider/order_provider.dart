import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_projects_start/api.dart';
import 'package:flutter_projects_start/model/cart_item.dart';
import 'package:flutter_projects_start/model/order.dart';
import 'package:flutter_projects_start/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';




final orderProvider = Provider((ref) => OrderProvider());
final historyProvider = FutureProvider.autoDispose((ref) => OrderProvider().getOrderHistory());
class OrderProvider {


  Future<List<Order>> getOrderHistory()async{
    final box = Hive.box<User>('user').values.toList();
    try{
      final dio = Dio();
      final response = await dio.get('${Api.getOrder}/${box[0].id}', options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${box[0].token}',
          }
      ));

      final data = (response.data as List).map((e) => Order.fromJson(e)).toList();


      return   data;
    }on DioError catch(err){
      throw '${err.message}';
    }
  }


  Future<String> addOrder({required int total, required List<CartItem> products})async{
    final box = Hive.box<User>('user').values.toList();
    try{
      final dio = Dio();

      final response = await dio.post(Api.createOrder, data: {
        'amount': total,
        'dateTime': DateTime.now().toIso8601String(),
        'products': products.map((e) => e.toJson()).toList(),
        'id': box[0].id
      }, options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${box[0].token}',
          }
      ));

      return 'success';
    }on DioError catch(err){
      return '${err.message}';
    }
  }


}