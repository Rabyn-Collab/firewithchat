import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final chatProvider = Provider((ref) => ChatProvider());

class ChatProvider{
  
  Future<types.Room?>  createRoom(types.User otherUser) async{
    try{
      final response  = await FirebaseChatCore.instance.createRoom(otherUser);
      return response;
  } on FirebaseException catch (err){
      print(err);
      return null;
  }


  }



}