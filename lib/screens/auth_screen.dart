import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_projects_start/provider/auth_provider.dart';
import 'package:flutter_projects_start/provider/image_provider.dart';
import 'package:flutter_projects_start/provider/login_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class AuthScreen extends StatelessWidget {

  final userNameController = TextEditingController();
  final mailController = TextEditingController();
  final passwordController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: _form,
        child: Consumer(
          builder: (context, ref, child) {
            final isLogin = ref.watch(loginProvider);
            final image = ref.watch(imageProvider).image;
            return ListView(
              children: [
           Container(
               margin: EdgeInsets.only(bottom: 50),
               child: Text(isLogin ? 'Login Form' : 'Sign Up Form', style: TextStyle(fontSize: 20),)),
              if(!isLogin)  TextFormField(
                  controller: userNameController,
                  validator: (val) {
                    if(val!.isEmpty){
                      return 'please provide username';
                    }else if(val.length > 15){
                      return 'maximum character is 15';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'username'
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: mailController,
                  validator: (val) {
                    if(val!.isEmpty){
                      return 'please provide email';
                    }else if(!val.contains('@')){
                      return 'please provide valid email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'email'
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: passwordController,
                  validator: (val) {
                    if(val!.isEmpty){
                      return 'please provide password';
                    }else if(val.length > 15){
                      return 'maximum character is 15';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'password'
                  ),
                ),
                SizedBox(height: 20,),
              if(!isLogin)  InkWell(
                  onTap: (){
                    ref.read(imageProvider).pickImage();
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                    ),
                    child: image ==null ? Center(child: Text('please select an image'))
                        : Image.file(File(image.path), fit: BoxFit.cover,),
                  ),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                    onPressed: () async{
                      _form.currentState!.save();
                      FocusScope.of(context).unfocus();
                      if(_form.currentState!.validate()){
                        if(isLogin){
                          final response = await ref.read(authProvider).userLogin(
                              email: mailController.text.trim(),
                              password: passwordController.text.trim()
                          );
                       if(response != 'success') {
                         ScaffoldMessenger.of(context).hideCurrentSnackBar();
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                             duration: Duration(seconds: 1),
                             content: Text(response)
                         ));
                       }

                        }else{
                         if(image == null){
                           ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(milliseconds: 500),
                                content: Text('please select an image')
                            ));
                         }else{

                       final response =   await ref.read(authProvider).userSignUp(
                             username: userNameController.text.trim(),
                             email: mailController.text.trim(),
                             password: passwordController.text.trim(),
                             image: image);

                       if(response != 'success'){
                         ScaffoldMessenger.of(context).hideCurrentSnackBar();
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                             duration: Duration(seconds: 1),
                             content: Text(response)
                         ));
                       }


                         }



                        }

                      }

                    }, child: Text('Submit')
                ),
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(isLogin ? 'Don\'t have an account' : 'Already have an account'),
                    TextButton(
                        onPressed: (){
                         ref.read(loginProvider.notifier).toggle();
                        }, child: Text(isLogin ? 'Sign Up': 'Login')
                    )
                  ],
                )

              ],
            );
          }
        ),
      ),
    );
  }
}
