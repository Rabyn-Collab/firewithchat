import 'dart:io';


import 'package:dio/dio.dart';
import 'package:flutter_projects_start/api.dart';
import 'package:flutter_projects_start/model/product.dart';
import 'package:flutter_projects_start/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';


final productProvider = FutureProvider((ref) => ProductProvider().getProducts());
final crudProvider = Provider((ref) => ProductProvider());

class ProductProvider{



  Future<List<Product>> getProducts()async{
    try{
      final dio = Dio();
      final response = await dio.get(Api.baseUrl);

       final data = (response.data as List).map((e) => Product.fromJson(e)).toList();
      return   data;
    }on DioError catch(err){
      throw '${err.message}';
    }
  }


  Future<String> addProduct({
    required String product_name,
    required String product_detail, required int price, required XFile image})async{
    final box = Hive.box<User>('user').values.toList();
    try{
      final dio = Dio();
      final formData = FormData.fromMap({
        'product_name' : product_name,
        'product_detail' : product_detail,
        'price': price,
        'photo': await MultipartFile.fromFile(image.path)
      });

      final response = await dio.post(Api.productCreate, data: formData, options: Options(
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${box[0].token}',
        }
      ));

      return 'success';
    }on DioError catch(err){
      return '${err.message}';
    }
  }



  Future<String> updateProduct({
    required String product_name,
    required String product_detail, required int price, XFile? image, String? public_id, required String id})async{
    final dio = Dio();
    final box = Hive.box<User>('user').values.toList();
    try{
      if(image == null){
        final response = await dio.patch(Api.productUpdate + '/$id', data: {
          'product_name' : product_name,
          'product_detail' : product_detail,
          'price': price,
          'photo': 'no need to update'
        }, options: Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer ${box[0].token}',
            }
        ));
      }else{

        final formData = FormData.fromMap({
          'product_name' : product_name,
          'product_detail' : product_detail,
          'price': price,
          'public_id': public_id,
          'photo': await MultipartFile.fromFile(image.path)
        });

        final response = await dio.patch(Api.productUpdate + '/$id', data: formData, options: Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer ${box[0].token}',
            }
        ));
      }


      return 'success';
    }on DioError catch(err){
      return '${err.message}';
    }
  }





  Future<String> removeProduct({required String id, required String imageId})async{
    final box = Hive.box<User>('user').values.toList();
    try{
      final dio = Dio();
      final response = await dio.delete(Api.productCreate + '/$id', data: {
        'public_id': imageId
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