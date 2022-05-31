import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects_start/provider/crud_provider.dart';
import 'package:flutter_projects_start/provider/image_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class CreateScreen extends StatelessWidget {

  final titleController = TextEditingController();
  final descController = TextEditingController();

  final _form = GlobalKey<FormState>();
  final id = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: Consumer(
              builder: (context, ref, child) {
                final image = ref.watch(imageProvider).image;
                return ListView(
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 50),
                        child: Text('create Form', style: TextStyle(fontSize: 20),)),
                    TextFormField(
                      controller: titleController,
                      validator: (val) {
                        if(val!.isEmpty){
                          return 'please provide title';
                        }else if(val.length > 25){
                          return 'maximum character is 15';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'title'
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: descController,
                      maxLines: 2,
                      validator: (val) {
                        if(val!.isEmpty){
                          return 'please provide description';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'description'
                      ),
                    ),

                    SizedBox(height: 20,),
                    InkWell(
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
                          if(_form.currentState!.validate()) {
                            if (image == null) {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      duration: Duration(milliseconds: 500),
                                      content: Text('please select an image')
                                  ));
                            } else {
                              final response = await ref.read(crudProvider)
                                  .postAdd(
                                  title: titleController.text.trimLeft(),
                                  description: descController.text.trim(),
                                  userId: id,
                                  image: image
                              );
                              if (response != 'success') {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text(response)
                                    ));
                              } else {
                                Navigator.of(context).pop();
                              }
                            }
                          }



                        }, child: Text('Submit')
                    ),
                    SizedBox(height: 50,),


                  ],
                );
              }
          ),
        ),
      ),
    );
  }
}
