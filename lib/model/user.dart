import 'package:hive_flutter/adapters.dart';
part 'user.g.dart';


@HiveType(typeId: 0)
class User extends HiveObject{

  @HiveField(0)
  String username;

  @HiveField(1)
  String email;

  @HiveField(2)
  String token;

  User({
   required this.email,
    required this.username,
    required this.token
});


  factory User.fromJson(Map<String, dynamic> json){
    return User(
        email: json['email'],
        username: json['username'],
        token: json['token']
    );
  }


}