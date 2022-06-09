import 'package:flutter/material.dart';
import 'package:flutter_projects_start/provider/auth_provider.dart';
import 'package:flutter_projects_start/screens/create_screen.dart';
import 'package:flutter_projects_start/screens/customize_page.dart';
import 'package:flutter_projects_start/screens/order_history.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';



class DrawerWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: ( context, ref, child) {
          final userData = ref.watch(userProvider);
          return Drawer(
            child: ListView(
                    children: [
                  DrawerHeader(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1470252649378-9c29740c9fa8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fG5hdHVyZXxlbnwwfDB8MHx8&auto=format&fit=crop&w=500&q=60'),
                          colorFilter: ColorFilter.mode(
                              Colors.black12,
                              BlendMode.darken
                          ),
                          fit: BoxFit.cover
                        ),
                      ),
                      child: Text(userData[0].email),
                  ),

                      ListTile(
                        leading: Icon(Icons.info),
                        title: Text(userData[0].username),
                      ),
                      ListTile(
                        onTap: (){
                          Navigator.of(context).pop();
                          Get.to(() => CreateScreen(), transition: Transition.leftToRight);
                        },
                        leading: Icon(Icons.add),
                        title: Text('Create Post'),
                      ),

                      ListTile(
                        onTap: (){
                          Navigator.of(context).pop();
                          Get.to(() => CustomizeScreen(), transition: Transition.leftToRight);
                        },
                        leading: Icon(Icons.add_chart_outlined),
                        title: Text('Customize Post'),
                      ),
                      ListTile(
                        onTap: (){
                          Navigator.of(context).pop();
                          Get.to(() => OrderHistory(), transition: Transition.leftToRight);
                        },
                        leading: Icon(Icons.history),
                        title: Text('order_history'),
                      ),

                      ListTile(
                        onTap: (){
                          Navigator.of(context).pop();
                          ref.read(userProvider.notifier).logOut();
                        },
                        leading: Icon(Icons.exit_to_app),
                        title: Text('LogOut'),
                      ),
                    ],
          ));
        }
    );
  }
}
