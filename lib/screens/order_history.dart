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
                    data: (data){
                      print(data.length);
                      return ListView.builder(
                        itemCount: data.length,
                          itemBuilder: (context, index){
                           final dat = data[index];
                           return Container(
                             child: Column(
                               children: [
                                 Text(dat.DateTime),
                                 Text('${dat.total}')
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
