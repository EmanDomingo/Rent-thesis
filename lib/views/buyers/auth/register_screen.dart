import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_app/controllers/auth_controller.dart';
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

  late String address;

  late String phoneNumber;

  late String password;

  bool _isLoading = false;

  Uint8List? _image;

  _signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    if (_image == null) {
    setState(() {
      _isLoading = false;
    });
    return showSnack(context, 'Please select an image');
  }

    if (_formKey.currentState!.validate()) {
      await _authController
          .signUpUSers(email, fullName, address, phoneNumber, password, _image)
          .whenComplete(() {
        setState(() {
          _formKey.currentState!.reset();
          _isLoading = false;
        });
      });

      return Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return MainScreen();
      }));
      
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
        body: Container(
          decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromARGB(255, 107, 174, 230),Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 107, 174, 230),], // Add your gradient colors here
          ),
        ),
          child: Center(
              child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Register Account',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 20),
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
                                'https://cdn3.vectorstock.com/i/thumb-large/60/82/user-icon-white-silhouette-on-blue-round-vector-20326082.jpg'),
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
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid email address';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
        
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your full name';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      fullName = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
        
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your address';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      address = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
        
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid phone number';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
        
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a secure password';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
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
                                    letterSpacing: 2,
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
                      'Already have a account?',
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
              ],
            ),
          ),
              ),
            ),
        ));
  }
}
