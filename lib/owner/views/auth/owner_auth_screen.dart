import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/owner/views/auth/screens/landing_screen.dart';

class OwnerAuthScreen extends StatelessWidget {
  const OwnerAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
              // GoogleAuthProvider(cliendId:'204742374983-f74d8ksudq5vr1n3jv0q1chaaipfmo9l.apps.googleusercontent.com'),
              // GoogleAuthProvider(
              //   clientId: '',
              // ),
            ],
          );
        }

        return LandingScreen(); // You can show a loading indicator until navigation happens.
      },
    );
  }
}
