import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_projects_start/provider/chat_provider.dart';
import 'package:flutter_projects_start/screens/chat_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';



class UserDetail extends StatelessWidget {

  final types.User user;
  UserDetail(this.user);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(user.imageUrl!),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.firstName!),
                          Text(user.metadata!['email']),
                          Consumer(
                            builder: (context, ref, child) {
                              return ElevatedButton(
                                  onPressed: () async {
                                   final room = await ref.read(chatProvider).createRoom(user);

                                   if(room !=null){
                                     Get.to(() => ChatPage(room: room), transition: Transition.leftToRight);
                                   }

                                  }, child: Text('Chat Start'));
                            }
                          )
                        ],
                      )

                    ],
                  ),
                ),
              ],
            )
        )
    );
  }
}
