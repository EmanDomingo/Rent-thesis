

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class OwnerController {

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Function to store image in firebase store
  _uploadVendorImageToStorage(Uint8List? image) async {

    Reference ref = _storage.ref().child('storeImages').child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
  //Function to store image in firebase storage ends here

  //Function to pick store image
  pickStoreImage(ImageSource source) async{
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Image Selected');
    }
  }
  //Function to pick store image ends here

  //Function to save owners data
  Future <String> registerOwner(
    String bussinessName,
    String email,
    String phoneNumber,
    String countryValue,
    String stateValue,
    String cityValue,
    // String taxRegistered,
    // String taxNumber,
    
    Uint8List? image,) async {

      String res = 'some error occured';

      try {
        
            String storeImage = await _uploadVendorImageToStorage(image);
            //Save data to cloud firestore

            await _firestore
            .collection('owners')
            .doc(_auth.currentUser!.uid)
            .set({
              'bussinessName': bussinessName,
              'email': email,
              'phoneNumber': phoneNumber,
              'countryValue':countryValue,
              'stateValue':stateValue,
              'cityValue':cityValue,
              // 'taxRegistered':taxRegistered,
              // 'taxNumber':taxNumber,
              'storeImage':storeImage,
              'approved':false,
              'ownerId':_auth.currentUser!.uid,
            });
          ;
      } catch (e) {
        res = e.toString();
      }

      return res;
  }
  //Function to save owners data ends here
}