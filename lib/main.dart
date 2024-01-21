import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseexample/firebase_options.dart';
import 'package:firebaseexample/home_page.dart';
import 'package:firebaseexample/homepage.dart';
import 'package:firebaseexample/signin_page.dart';
import 'package:flutter/material.dart';

void main() async {
  //önce flutter ayağa kalkar sonra firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return const HomepageNew();
        } else {
          return SignInPage();
        }
      },
    ),
  ));
}
