import 'package:flutter/material.dart';
import 'package:flutter_projects_start/provider/cart_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CartScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Consumer(
              builder: (context, ref, child) {
                final cartData = ref.watch(cartProvider);
                final total = ref.watch(cartProvider.notifier).total;
                print(cartData.length);
                return cartData.isEmpty ? Center(child: Text('add some product', style: TextStyle(fontSize: 25),)) : Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: cartData.length,
                            itemBuilder: (context, index){
                              final cart = cartData[index];
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                margin: EdgeInsets.only(bottom: 15),
                                height: 200,
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Image.network(cart.imageUrl, height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,),
                                    SizedBox(width: 15,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(height: 15,),
                                              Text(cart.title),
                                              Spacer(),
                                              IconButton(onPressed: (){

                                              }, icon: Icon(Icons.delete))
                                            ],
                                          ),
                                          Text('Rs. ${cart.price}'),
                                            Spacer(),
                                          Row(
                                            children: [
                                              Spacer(),
                                              OutlinedButton(onPressed: (){}, child: Icon(Icons.add)),
                                              SizedBox(width: 10,),
                                              OutlinedButton(onPressed: (){}, child: Icon(Icons.remove)),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            })),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text('Total'),
                               Text('$total')
                             ],
                           )
                        ],
                      ),
                    )

                  ],
                );
              }
    ),
        )
    );
  }
}
