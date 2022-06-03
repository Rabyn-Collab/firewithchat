import 'package:dio/dio.dart';
import 'package:flutter_projects_start/api.dart';
import 'package:flutter_projects_start/main.dart';
import 'package:flutter_projects_start/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';



final userProvider = StateNotifierProvider<UserProvider, List<User>>((ref) => UserProvider(ref.read(box1)));

class UserProvider extends StateNotifier<List<User>>{
  UserProvider(super.state);



  Future<String> userSignUp({required String username, required String email, required String password})async{
   try{
     final dio = Dio();
     final response = await dio.post(Api.userSignUp, data: {
      'email': email,
       'full_name': username,
       'password': password
     });

     final newUser = User.fromJson(response.data);
     Hive.box<User>('user').add(newUser);
     state = [newUser];
     return 'success';
   }on DioError catch(err){
       return '${err.message}';
   }
  }


  Future<String> userLogin({required String email, required String password})async{
    try{
      final dio = Dio();
      final response = await dio.post(Api.userLogin, data: {
        'email': email,
        'password': password
      });

      final newUser = User.fromJson(response.data);
      Hive.box<User>('user').add(newUser);
      state = [newUser];
      return 'success';
    }on DioError catch(err){
      return '${err.message}';
    }
  }

  Future<void> logOut()async{
    Hive.box<User>('user').clear();
    state = [];
  }



}