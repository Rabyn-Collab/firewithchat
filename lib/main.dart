import 'package:flutter/material.dart';
import 'package:flutter_projects_start/model/cart_item.dart';
import 'package:flutter_projects_start/model/user.dart';
import 'package:flutter_projects_start/screens/status_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';




final box1 = Provider<List<User>>((ref) => []);
final box2 = Provider<List<CartItem>>((ref) => []);

void main () async{


  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CartItemAdapter());
  final userBox = await Hive.openBox<User>('user');
  final cartBox = await Hive.openBox<CartItem>('carts');
  runApp(
      ProviderScope(
        overrides: [
          box1.overrideWithValue(userBox.values.toList()),
          box2.overrideWithValue(cartBox.values.toList()),
        ],
      child: Home()));
}


// class Item {
//   int id;
//   String data;
//
//   Item({required this.id, required this.data});
//
//   @override
//   String toString() {
//     return 'Item($id , $data)';
//   }
// }

//
// List<Item> items = [
//   Item(id: 1, data: 'ldk;lsakd'),
//   Item(id: 2, data: 'a;sld;lasd'),
// ];

// Item m = items.firstWhere((element) => element.id == 1);

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     // m.id = 5;
     //
     // items = [
     //   for(final element in items)
     //     if(element == m) m else element
     // ];
     // print(items);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        home: StatusScreen()
    );
  }
}

