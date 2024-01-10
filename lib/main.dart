import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseexample/firebase_options.dart';
import 'package:firebaseexample/logIn_page.dart';
import 'package:firebaseexample/loginpage.dart';
import 'package:firebaseexample/signUp_page.dart';

import 'package:flutter/material.dart';

void main() async {
  //önce flutter ayağa kalkar sonra firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: SignUpPage()));
}
