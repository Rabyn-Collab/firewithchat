import 'package:flutter/material.dart';
import 'package:flutter_projects_start/model/user.dart';
import 'package:flutter_projects_start/screens/status_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';


final box1 = Provider<List<User>>((ref) => []);

void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  final userBox = await Hive.openBox<User>('user');
  runApp(
      ProviderScope(
        overrides: [
          box1.overrideWithValue(userBox.values.toList()),
        ],
      child: Home()));
}




class Home extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        home: StatusScreen()
    );
  }
}

