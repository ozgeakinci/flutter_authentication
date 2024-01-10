import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseexample/homePage.dart';
import 'package:firebaseexample/signUp_page.dart';

import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  void _showErrorDialog(String error) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Hata'),
            content: Text(error),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Tamam"))
            ],
          );
        });
  }

  Future<void> _signIn() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog("Lütfen kullanıcı adı ve şifre giriniz.");
      return;
    }
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        print("Giriş başarılı: ${user.email}");
      } else {
        _showErrorDialog(
            "Giriş başarısız. Lütfen kullanıcı adı ve şifrenizi kontrol edin.");
      }
    } on FirebaseAuthException catch (e) {
      _showErrorDialog("Bir hata oluştu: ${e.message}");
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
                  Positioned(
                    left: 36,
                    top: 396,
                    child: Container(
                      width: 340,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 20) +
                                  const EdgeInsets.only(left: 40),
                          hintText: _hintText,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 36,
                    top: 476,
                    child: Container(
                      width: 340,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 20) +
                                  const EdgeInsets.only(left: 40),
                          hintText: _hintTextPassword,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 275,
                    top: 560,
                    child: InkWell(
                      onTap: () {
                        _signIn();
                        if (_emailController.text.isNotEmpty ||
                            _passwordController.text.isNotEmpty)
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
