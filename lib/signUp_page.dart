import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseexample/homePage.dart';
import 'package:firebaseexample/logIn_page.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      print("Kayıt hatası: ${e.message}");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    const String _hintText = 'Your Email';
    const String _hintTextPassword = 'Password';

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
                    top: 546,
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
                        'Create Account',
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
                      'Sign Up',
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
                    left: 280,
                    top: 795,
                    child: Container(
                      width: 80,
                      height: 9,
                      decoration: BoxDecoration(
                          color: Color(0x840A7DE7).withOpacity(0.3)),
                    ),
                  ),
                  Positioned(
                    left: 284,
                    top: 780,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInPage()));
                      },
                      child: const Text(
                        'Sign In',
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
                      onTap: () async {
                        String email = _emailController.text;
                        String password = _passwordController.text;

                        User? user = await signUp(email, password);

                        if (user != null) {
                          print("Kayıt başarılı: ${user.email}");
                        } else {
                          print("Kayıt başarısız");
                        }
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
