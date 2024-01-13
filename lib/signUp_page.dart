import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseexample/signin_page.dart';
import 'package:flutter/material.dart';

final firebaseAutInstance = FirebaseAuth.instance;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<SignUpPage> {
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';

  void _onSubmit() async {
    _formKey.currentState!.save();

    try {
      UserCredential userCredential = await firebaseAutInstance
          .createUserWithEmailAndPassword(email: _email, password: _password);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Kayıt başarılı')));
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message!)));
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
                  //********************* FORM AREA ********************
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
                        _onSubmit();
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
