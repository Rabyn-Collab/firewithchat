import 'package:flutter/material.dart';
import 'package:flutter_projects_start/provider/auth_provider.dart';
import 'package:flutter_projects_start/provider/crud_provider.dart';
import 'package:flutter_projects_start/screens/create_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';



class DrawerWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: ( context, ref, child) {
          final userData = ref.watch(userSingleStream);
          return Drawer(
            child: userData.when(
                data: (data){
                  return ListView(
                    children: [
                  DrawerHeader(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(data.imageUrl!),
                          colorFilter: ColorFilter.mode(
                              Colors.black12,
                              BlendMode.darken
                          ),
                          fit: BoxFit.cover
                        ),
                      ),
                      child: Text(data.metadata!['email']),
                  ),

                      ListTile(
                        leading: Icon(Icons.info),
                        title: Text(data.firstName!),
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
                          ref.read(authProvider).userLogOut();
                        },
                        leading: Icon(Icons.exit_to_app),
                        title: Text('LogOut'),
                      ),
                    ],
                  );
                },
                error: (err, stack) => Center(child: Text('$err'),),
                loading: () => Center(child: CircularProgressIndicator(
                  color: Colors.purple,
                ),)
            ),
          );
        }
    );
  }
}
