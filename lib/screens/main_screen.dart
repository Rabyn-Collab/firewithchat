import 'package:flutter/material.dart';
import 'package:flutter_projects_start/provider/auth_provider.dart';
import 'package:flutter_projects_start/provider/product_provider.dart';
import 'package:flutter_projects_start/screens/cart_screen.dart';
import 'package:flutter_projects_start/screens/detail_screen.dart';
import 'package:flutter_projects_start/widgets/drawer_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';


class MainScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final box = ref.watch(userProvider);
        final products = ref.watch(productProvider);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: Text('Sample Shop'),

            actions: [
              TextButton(
                  onPressed: (){
                    Get.to(() => CartScreen(), transition:  Transition.leftToRight);
                  }, child: Text('Cart Page', style: TextStyle(color: Colors.white),))
            ],
          ),
            drawer: DrawerWidget(),
            body: SafeArea(
                child: products.when(
                    data: (data){
                     return Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                       child: GridView.builder(
                         itemCount: data.length,
                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                             crossAxisCount: 2,
                             mainAxisSpacing: 5,
                               crossAxisSpacing: 4,
                             childAspectRatio: 2/3
                           ),
                           itemBuilder: (context, index){
                           return InkWell(
                             onTap: (){
                               Get.to(() => DetailScreen(product: data[index]), transition: Transition.leftToRight);
                             },
                             child: GridTile(
                                 child: Hero(
                                     tag: data[index].id,
                                     child: Image.network(data[index].image)),
                             footer: Container(
                               height: 37,
                               child: GridTileBar(
                                 backgroundColor: Colors.black,
                                 title: Text(data[index].product_name),
                                 trailing: Text('Rs. ${data[index].price}', style: TextStyle(color: Colors.white),),
                               ),
                             ),
                             ),
                           );
                           }
                       ),
                     );
                    },
                    error: (err, _) => Center(child: Text('$err')),
                    loading: () => Center(child: CircularProgressIndicator(),),
                ),
            )
        );
      }
    );
  }
}
