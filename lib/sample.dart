import 'package:get/get.dart';
import 'package:flutter/material.dart';



class CounterController extends GetxController{
   Rx<int> number = 0.obs;

   void increment(){
     number.value++;
   }


}




class CounterApp extends StatelessWidget {

  final count = Get.put(CounterController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Column(
          children: [
            Obx(() => Text('${count.number.value}')),
            TextButton(
                onPressed: (){
                count.increment();
            }, child: Text('increment'))
          ],
        )
    );
  }
}
