import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';



final imageProvider = ChangeNotifierProvider((ref) => ImageProvider());

class ImageProvider extends ChangeNotifier{

  XFile? image;

    void pickImage() async{
      final ImagePicker _picker = ImagePicker();
       image = await _picker.pickImage(source: ImageSource.gallery);
       notifyListeners();
    }



}