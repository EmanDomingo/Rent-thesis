import 'package:flutter/material.dart';
import 'package:rental_app/controllers/auth_controller.dart';
import 'package:rental_app/owner/views/auth/owner_auth_screen.dart';
import 'package:rental_app/utils/show_snackBar.dart';
import 'package:rental_app/views/buyers/auth/register_screen.dart';
import 'package:rental_app/views/buyers/main_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  late String email;

  late String password;

  bool _isLoading = false;

  _loginUsers () async {
    
    if (_formKey.currentState!.validate()) {
      String res = await _authController.LoginUsers(email, password);

      if (res == 'success') {
      return Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return MainScreen();
      }));

      } else {
        return showSnack(context, res);
      }
    } else {
      return showSnack(context, 'You Are Now Logged In');
    }
  }

  //   } else {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     return showSnack(context, 'Please fields most not be emty');
  //   }
  // }


  // _loginUsers () async {
  //   setState(() {
  //     _isLoading = true;
  //   });
    
  //   if (_formKey.currentState!.validate()) {
  //     await _authController
  //     .LoginUsers(email, password);
  //     return Navigator.pushReplacement(context,
  //         MaterialPageRoute(builder: (BuildContext context) {
  //       return MainScreen();
  //     }));

  //     // } else {

  //     //   return showSnack(context, res);
  //     // }
  //     //return showSnack(context, 'You Are Now Logged In');
  //   } else {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     return showSnack(context, 'Please fields most not be emty');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login Customer"s Account',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Email field must not be emty';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  labelText: 'Enter Email Address',
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
                  labelText: 'Enter Password',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MainScreen()),
                    _loginUsers());
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
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                        ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Need An Account?',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return BuyerRegisterScreen();
                    }));
                  },
                  child: Text(
                    'Register',
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
    ));
  }
}
