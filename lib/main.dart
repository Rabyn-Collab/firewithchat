import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_projects_start/notification_service.dart';
import 'package:flutter_projects_start/screens/status_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

}
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  importance: Importance.high,
);


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


void main() async{
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
 SystemChrome.setSystemUIOverlayStyle(
   SystemUiOverlayStyle(statusBarColor: Colors.black)
 );
 FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
 await flutterLocalNotificationsPlugin
     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
     ?.createNotificationChannel(channel);
 LocalNotificationService.initialize();
  runApp(ProviderScope(child: Home()));
}

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: StatusScreen(),
    );
  }
}






//
//
// class Counter extends StatelessWidget {
//
//     int number = 0;
//
//    StreamController<int>  nController = StreamController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             StreamBuilder<Object>(
//               stream: nController.stream,
//               builder: (context, snapshot) {
//                 // if(snapshot.connectionState == ConnectionState.waiting){
//                 //
//                 // }
//                 if(snapshot.hasData){
//                   return Center(child: Text('${snapshot.data}', style: TextStyle(fontSize: 50),));
//                 }else{
//                   return Container(
//                     child: Center(child: Text('${snapshot.data}', style: TextStyle(fontSize: 50),)),
//                   );
//                 }
//
//               }
//             ),
//           ],
//         ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//            nController.sink.add(number++);
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

