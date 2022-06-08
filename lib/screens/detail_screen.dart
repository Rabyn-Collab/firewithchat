import 'package:flutter/material.dart';
import 'package:flutter_projects_start/model/product.dart';
import 'package:flutter_projects_start/provider/cart_provider.dart';
import 'package:flutter_projects_start/screens/cart_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';



class DetailScreen extends StatelessWidget {
  final Product product;
  const DetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 200),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 150,),
                      Expanded( child: Text(product.product_detail, style: TextStyle(fontSize: 19, color: Colors.blueGrey),)),
                      Consumer(
                        builder: (context, ref, child) {
                          return Container(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black
                                ),
                                onPressed: () {
                                  final response = ref.read(cartProvider.notifier).addProduct(product);
                                  if(response == 'success'){
                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      duration: Duration(seconds: 1),
                                      action: SnackBarAction(label: 'go to cart', onPressed: (){
                                        Get.to(() => CartScreen(), transition:  Transition.leftToRight);
                                      }),
                                        content:Text('successfully added to cart') ),
                                    );
                                  }else{

                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        duration: Duration(seconds: 1),
                                        action: SnackBarAction(label: 'go to cart', onPressed: (){
                                          Get.to(() => CartScreen(), transition:  Transition.leftToRight);
                                        }),
                                        content:Text(response) ),
                                    );

                                  }
                                }, child: Text('Add To Cart')),
                          );
                        }
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 300,
                width: double.infinity,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      margin: EdgeInsets.only(bottom: 100),
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.product_name, style: TextStyle(fontSize: 20, color: Colors.white),),
                          Text('Rs. ${product.price}', style: TextStyle(fontSize: 20, color: Colors.white),)
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                        width: 250,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Hero(
                                tag: product.id,
                                child: Image.network(product.image, fit: BoxFit.cover,)))),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
