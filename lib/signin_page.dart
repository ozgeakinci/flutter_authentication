import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseexample/home_page.dart';

import 'package:firebaseexample/signUp_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final firebaseAuthInstance = FirebaseAuth.instance;

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode = FocusNode();
  var _email = '';
  var _password = '';

  void _submit() async {
    try {
      _formKey.currentState!.save();
      UserCredential _userCredential =
          await firebaseAuthInstance.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Kayıt Başarısız')));
    }
  }

  void _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      final UserCredential userCredential =
          await firebaseAuthInstance.signInWithCredential(credential);

      print(userCredential.user?.email);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    const String _hintText = 'Your Email';
    const String _hintTextPassword = 'Password';
    const String _loginIn = 'Giriş';
    const String _isMember = 'Hala üye değil misiniz?';
    const String _registerText = 'Kayıt ol';
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: const Color(0xFFD7E5FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x26000000),
                    blurRadius: 75,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 235,
                    top: -16,
                    child: Container(
                      width: 398,
                      height: 398,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFB0CBFF),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -184,
                    top: -412,
                    child: Container(
                      width: 700,
                      height: 700,
                      decoration: const ShapeDecoration(
                        color: Color(0xD8367CFE),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 36,
                    top: 132,
                    child: SizedBox(
                      width: 216,
                      height: 109,
                      child: Text(
                        'Welcome Back',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 46,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 36,
                    top: 579,
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 36,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 36,
                    top: 755,
                    child: Container(
                      width: 78,
                      height: 9,
                      decoration: BoxDecoration(
                          color: Color(0x840A7DE7).withOpacity(0.3)),
                    ),
                  ),
                  Positioned(
                    left: 180,
                    top: 755,
                    child: Container(
                      width: 180,
                      height: 9,
                      decoration: BoxDecoration(
                          color: Color(0x84FF0000).withOpacity(0.3)),
                    ),
                  ),
                  Positioned(
                    left: 41,
                    top: 740,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()));
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w900,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 184,
                    top: 740,
                    child: Text(
                      'Forgot Passwords',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w900,
                        height: 0,
                      ),
                    ),
                  ),

                  // Form Area
                  Positioned(
                    top: 390,
                    left: 30,
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              width: 340,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: TextFormField(
                                focusNode: myFocusNode,
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (newValue) {
                                  _email = newValue!;
                                },
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 20) +
                                          const EdgeInsets.only(left: 40),
                                  hintText: _hintText,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 340,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: TextFormField(
                                obscureText: true,
                                onSaved: (newValue) {
                                  _password = newValue!;
                                },
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 20) +
                                          const EdgeInsets.only(left: 40),
                                  hintText: _hintTextPassword,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  Positioned(
                    left: 275,
                    top: 560,
                    child: InkWell(
                      onTap: () {
                        _submit();
                        // _signIn();
                        if (_email.isNotEmpty || _password.isNotEmpty)
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                      },
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(100)),
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                      top: 650,
                      left: 40,
                      child: TextButton.icon(
                          onPressed: () {
                            _signInWithGoogle();
                          },
                          label: Text('hey'),
                          icon: Icon(Icons.sign_language_outlined)))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
