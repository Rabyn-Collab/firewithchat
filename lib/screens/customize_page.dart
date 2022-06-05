import 'package:flutter/material.dart';
import 'package:flutter_projects_start/provider/product_provider.dart';
import 'package:flutter_projects_start/widgets/drawer_widget.dart';
import 'package:flutter_projects_start/widgets/edit_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';


class CustomizeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ref, child) {
          final products = ref.watch(productProvider);
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.purple,
                title: Text('Customize Product'),
              ),
              drawer: DrawerWidget(),
              body: SafeArea(
                child: products.when(
                  data: (data){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index){
                            return Card(
                              child: ListTile(
                                leading: Image.network(data[index].image),
                                title: Text(data[index].product_name),
                                    trailing: Container(
                                      width: 100,
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: (){
                                                Get.to(() => EditScreen(data[index]), transition: Transition.leftToRight);
                                              }, icon: Icon(Icons.edit)),
                                          IconButton(
                                              onPressed: (){

                                              }, icon: Icon(Icons.delete)),

                                        ],
                                      ),
                                    )

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
