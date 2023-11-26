import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/provider/cart_provider.dart';
import 'package:rental_app/provider/product_provider.dart';
import 'package:rental_app/views/buyers/nav_screens/landing_first_screen.dart';
//import 'chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: kIsWeb || Platform.isAndroid
          ? FirebaseOptions(
              authDomain: "rental-app-68251.firebaseapp.com",
              apiKey: "AIzaSyDNVg3Pt00uUaqzj9huGL7WIVGmLfzTV-0",
              appId: "1:204742374983:android:93f104a7aaa2fed6aae362",
              messagingSenderId: "204742374983",
              projectId: "rental-app-68251",
              storageBucket: "rental-app-68251.appspot.com",
            )
          : null);
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) {
        return ProductProvider();
      }),
      ChangeNotifierProvider(create: (_) {
        return CartProvider();
      }),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 0, 0)),
        useMaterial3: true,
        //fontFamily: 'JosefinSans',//fontFamily: 'IndustrialSans'
      ),
      home: LandingFirstScreen(),
      builder: EasyLoading.init(),
    );
  }
}
