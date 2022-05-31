import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';



final userStream =  StreamProvider.autoDispose((ref) => FirebaseAuth.instance.authStateChanges());
final authProvider = Provider((ref) => AuthProvider());



class AuthProvider{


    CollectionReference userDB = FirebaseFirestore.instance.collection('users');


  Future<String> userLogin({required String email, required String password}) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
       return 'success';
    }on FirebaseAuthException catch (err){
      return '${err.message}';

    }
  }


  Future<String> userSignUp({required String username,
    required String email, required String password, required XFile image}) async{

       try{
         // final imageId = DateTime.now().toIso8601String();
         final ref =  FirebaseStorage.instance.ref().child('userImages/${image.name}');
         final imageFile = File(image.path);
         await ref.putFile(imageFile);
         final imageUrl = await ref.getDownloadURL();
         final userData =  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
   await FirebaseChatCore.instance.createUserInFirestore(types.User(
     id: userData.user!.uid,
     imageUrl: imageUrl,
     firstName: username,
       metadata: {
       'email': email
       },
       createdAt: DateTime.now().millisecondsSinceEpoch
   ));

       return 'success';
       }on FirebaseAuthException catch (err){
          return '${err.message}';
       }



  }


    Future<void> userLogOut() async{
         try{
         await FirebaseAuth.instance.signOut();
         }on FirebaseAuthException catch (err){
            print(err);
         }
    }



}