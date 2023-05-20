import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageHelper {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadCategoryImage(File imageFile) async {
    String fileName = imageFile.path.split('/').last;
    Reference storageReference =
        FirebaseStorage.instance.ref().child('category_images/$fileName');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> uploadProductImage(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child('product_images/$fileName');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
