import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects_start/model/post.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_projects_start/notification_service.dart';
import 'package:flutter_projects_start/provider/auth_provider.dart';
import 'package:flutter_projects_start/provider/crud_provider.dart';
import 'package:flutter_projects_start/screens/detail_screen.dart';
import 'package:flutter_projects_start/screens/edit_screen.dart';
import 'package:flutter_projects_start/screens/recent_chats.dart';
import 'package:flutter_projects_start/widgets/drawer_widget.dart';
import 'package:flutter_projects_start/widgets/user_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';


class MainScreen extends StatefulWidget {

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final user = FirebaseAuth.instance.currentUser;

  late types.User currentUser;


  @override
  void initState() {
    super.initState();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
          (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);

        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );
    getToken();
  }

  Future getToken() async{
    final token = await FirebaseMessaging.instance.getToken();
    print(token);
  }



  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final userData = ref.watch(usersStream);
        final postData = ref.watch(postStream);
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.purple,
              title: Text('FireApp'),
              actions: [
                TextButton(
                    onPressed: (){
                      Get.to(() => RecentChats(), transition: Transition.leftToRight);
                    }, child: Text('Recent Chats', style: TextStyle(
                  color: Colors.white
                ),))
              ],

            ),
            drawer: DrawerWidget(),
            body: Column(
              children: [
                Container(
                 height: 150,
                  child: userData.when(
                      data: (data){
                        final otherData = data.where((element) => element.id != user!.uid).toList();
                        currentUser = data.firstWhere((element) => element.id == user!.uid);
                        return  ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: otherData.length,
                            itemBuilder: (context, index){
                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                  InkWell(
                                    onTap: (){
                                      Get.to(() => UserDetail(otherData[index]), transition: Transition.leftToRight);
                                    },
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(otherData[index].imageUrl!),
                                    ),
                                  ),
                                    SizedBox(height: 7,),
                                    Text(otherData[index].firstName!),
                                  ],
                                ),
                              );
                            }
                        );
                      },
                      error: (err, stack) => Text('$err'),
                      loading: () => Container()
                  )
                ),

                Expanded(
                  child: Container(
                      child: postData.when(
                          data: (data){
                            return  ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index){
                                  final dat = data[index];
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Container(
                                        height: 400,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(dat.title),
                                            if(user!.uid == dat.userId)    TextButton(
                                                    style: TextButton.styleFrom(
                                                      minimumSize: Size.zero, // Set this
                                                      padding: EdgeInsets.zero, // and this
                                                    ),
                                                    onPressed: (){
                                               Get.defaultDialog(
                                                 title: 'Customize Post',
                                                 content: Text('edit or remove your post'),
                                                 actions: [
                                                   IconButton(
                                                       onPressed: (){
                                                         Navigator.of(context).pop();
                                                          Get.to(() => EditScreen(dat), transition:  Transition.leftToRight);
                                                   }, icon: Icon(Icons.edit)),
                                                   IconButton(
                                                       onPressed: (){
                                                         Navigator.of(context).pop();

                                                         Get.defaultDialog(
                                                             title: 'Remove Post',
                                                             content: Text('Are you sure you want to remove this post'),
                                                             actions: [
                                                               TextButton(
                                                                   onPressed: (){
                                                                     Navigator.of(context).pop();
                                                                     ref.read(crudProvider).postRemove(
                                                                         postId: dat.postId, imageId: dat.imageId);
                                                                   }, child: Text('yes')),
                                                               TextButton(
                                                                   onPressed: (){
                                                                     Navigator.of(context).pop();

                                                                   }, child: Text('no')),
                                                             ]
                                                         );

                                                       }, icon: Icon(Icons.delete))
                                                 ]
                                               );
                                                    },
                                                    child: Icon(Icons.more_vert)
                                                )
                                              ],
                                            ),
                                            InkWell(
                                              onTap: (){
                                                Get.to(() => DetailScreen(dat, currentUser), transition: Transition.leftToRight);
                                              },
                                              child: FittedBox(
                                                child: Hero(
                                                  tag: dat.imageUrl,
                                                  child: Image.network(dat.imageUrl,
                                                    height: 300,
                                                    width: 360,
                                                    fit: BoxFit.fill,),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(dat.description, maxLines: 2, overflow: TextOverflow.ellipsis,),
                                                  Spacer(),
                                             if(user!.uid != dat.userId)   Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: (){
                                                          if(dat.like.usernames.contains(currentUser.firstName!)){
                                                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                              duration: Duration(milliseconds:700),
                                                                // action: SnackBarAction(label: '', onPressed: (){
                                                                //
                                                                // }),
                                                                content: Text('You\'ve already like this post')
                                                            ));
                                                          }else{
                                                            final newLike = Like(
                                                                likes: dat.like.likes + 1,
                                                                usernames: [...dat.like.usernames,currentUser.firstName! ]
                                                            );

                                                            ref.read(crudProvider).addLike(postId: dat.postId, like: newLike);


                                                          }

                                                    }, icon: Icon(Icons.thumb_up),
                                                    ),
                                                  if(dat.like.likes != 0)  Text('${dat.like.likes}')
                                                  ],
                                                )

                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            );
                          },
                          error: (err, stack) => Text('$err'),
                          loading: () => Container()
                      )
                  ),
                ),


              ],
            )
        );
      }
    );
  }
}
