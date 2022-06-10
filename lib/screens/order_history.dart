import 'package:flutter/material.dart';
import 'package:flutter_projects_start/provider/order_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class OrderHistory extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Consumer(
              builder: (context, ref, child) {
                final orderData = ref.watch(historyProvider);
                return orderData.when(
                    data: (data){;
                      return ListView.builder(
                        itemCount: data.length,
                          itemBuilder: (context, index){
                           final dat = data[index];
                           return Container(
                             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(dat.DateTime),
                                Container(
                                  width: double.infinity,
                                  child:  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: dat.products.map((e){
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Image.network(e.imageUrl, height: 160, width: 200,
                                            fit: BoxFit.fill,
                                            ),
                                            SizedBox(width: 10,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(e.title, style: TextStyle(fontSize: 20),),
                                                Text('${e.price}'),
                                                Text('x ${e.quantity}'),
                                              ],
                                            ),

                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                 Row(
                                   children: [
                                     Text('Total:-', style: TextStyle(fontSize: 20),),
                                     Spacer(),
                                     Text('${dat.total}', style: TextStyle(fontSize: 17),),
                                   ],
                                 )
                               ],
                             ),
                           );
                          }
                      );
                    },
                    error: (err, stack) => Center(child: Text('$err')),
                    loading: () => Center(child: CircularProgressIndicator(
                      color: Colors.purple,
                    ),)
                );
              }
                ),
        )
    );
  }
}
