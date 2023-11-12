import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_app/controllers/auth_controller.dart';
import 'package:rental_app/owner/views/auth/owner_auth_screen.dart';
import 'package:rental_app/utils/show_snackBar.dart';
import 'package:rental_app/views/buyers/auth/login_screen.dart';
import 'package:rental_app/views/buyers/main_screen.dart';

class BuyerRegisterScreen extends StatefulWidget {
  @override
  State<BuyerRegisterScreen> createState() => _BuyerRegisterScreenState();
}

class _BuyerRegisterScreenState extends State<BuyerRegisterScreen> {
  final AuthController _authController = AuthController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String email;

  late String fullName;

  late String phoneNumber;

  late String password;

  bool _isLoading = false;

  Uint8List? _image;

  _signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      await _authController
          .signUpUSers(email, fullName, phoneNumber, password, _image)
          .whenComplete(() {
        setState(() {
          _formKey.currentState!.reset();
          _isLoading = false;
        });
      });

      return showSnack(
          context, 'Congratulations An Account Has Been Created For You');
    } else {
      setState(() {
        _isLoading = false;
      });
      return showSnack(context, 'Please Fields must not be empty');
    }
  }

  selectGalleryImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  selectCameraImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.camera);

    setState(() {
      _image = im;
    });
  }

  // _signUpUser()async{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create Customer"s Account',
                style: TextStyle(fontSize: 20),
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.blue.shade400,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.blue.shade400,
                          backgroundImage: NetworkImage(
                              'https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg'),
                        ),
                  Positioned(
                    right: 0,
                    top: 5,
                    child: IconButton(
                      onPressed: () {
                        selectGalleryImage();
                      },
                      icon: Icon(CupertinoIcons.photo),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Email must not be emty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Email',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Full Name must not be emty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    fullName = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Full Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Phone Number must not be emty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    phoneNumber = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Phone Number',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Password must not be emty';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => MainScreen()),
                      (route) => false);
                },
                child: GestureDetector(
                  onTap: () {
                    _signUpUser();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade500,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade600,
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                        child: _isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3,
                                ),
                              )),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already Have An Account?',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      }));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create Owners Account?',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return OwnerAuthScreen();
                      }));
                    },
                    child: Text(
                      'Create',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
