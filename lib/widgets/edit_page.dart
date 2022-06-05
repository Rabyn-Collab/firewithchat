import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_projects_start/model/product.dart';
import 'package:flutter_projects_start/provider/image_provider.dart';
import 'package:flutter_projects_start/provider/product_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class EditScreen extends StatelessWidget {

  final Product product;
  EditScreen(this.product);

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();

  final _form = GlobalKey<FormState>();
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
                      controller: titleController..text = product.product_name,
                      textInputAction: TextInputAction.next,
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
                      controller: descController..text = product.product_detail,
                      textInputAction: TextInputAction.next,
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
                    TextFormField(
                      controller: priceController..text = '${product.price}',
                      keyboardType : TextInputType.number,
                      textInputAction: TextInputAction.done,
                      validator: (val) {
                        if(val!.isEmpty){
                          return 'please provide price';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'price'
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
                        child: image ==null ? Image.network(product.image)
                            : Image.file(File(image.path), fit: BoxFit.cover,),
                      ),
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(
                        onPressed: () async{
                          _form.currentState!.save();
                          SystemChannels.textInput.invokeMethod('TextInput.hide');
                          if(_form.currentState!.validate()) {
                            if (image == null) {
                               final response = await ref.read(crudProvider).updateProduct(
                                   product_name: titleController.text.trimLeft(),
                                   product_detail: descController.text.trim(),
                                   price: int.parse(priceController.text.trim()),
                                   id: product.id);
                               ref.refresh(productProvider);
                               Navigator.of(context).pop();
                            } else {
                              final response = await ref.read(crudProvider)
                                  .updateProduct(
                                  product_name: titleController.text.trimLeft(),
                                  product_detail: descController.text.trim(),
                                  price: int.parse(priceController.text.trim()),
                                  image: image,
                                  id: product.id,
                                public_id: product.public_id
                              );
                              ref.refresh(productProvider);
                                Navigator.of(context).pop();

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
