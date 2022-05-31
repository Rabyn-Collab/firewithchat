import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects_start/provider/crud_provider.dart';
import 'package:flutter_projects_start/screens/chat_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;




class RecentChats extends StatelessWidget {


  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Consumer(
              builder: (context, ref, child) {
                final roomData = ref.watch(roomStream);
                return roomData.when(
                    data: (data){
                      if(data.isEmpty){
                        return Center(child: Text('No recent Chats'));
                      }else{
                        return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index){
                              List<types.User> users = data[index].users;
                              final friendData = users.firstWhere((element) => element.id != userId);
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                child: ListTile(
                                  onTap: (){
                                    Get.to(() => ChatPage(room:data[index]), transition: Transition.leftToRight);
                                  },
                                  leading: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                      friendData.imageUrl!
                                    ),
                                  ),
                                  title: Text(friendData.firstName!),
                                ),
                              );
                            }
                        );
                      }

                    },
                    error: (err, stack) => Text('$err'),
                    loading: () => Center(child: CircularProgressIndicator(),)
                );
              }
    ),
        )
    );
  }
}
