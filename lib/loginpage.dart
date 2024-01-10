import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebaseexample/homePage.dart';
import 'package:firebaseexample/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    const String _hintText = 'Kullanıcı Adı';
    const String _hintTextPassword = 'Şifre';
    const String _loginIn = 'Giriş';
    const String _isMember = 'Hala üye değil misiniz?';
    const String _registerText = 'Kayıt ol';

    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: 350,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: _hintText,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                prefixIcon: Icon(Icons.person_2_rounded),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: 350,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: _hintTextPassword,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                prefixIcon: Icon(Icons.lock),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Şifremi Unuttum',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            print('tıklandı');
                            _signIn();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          },
                          child: const Text(_loginIn),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  _isMember,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterPage()));

                                    // String email = _emailController.text;
                                    // String password = _passwordController.text;

                                    // User? user = await signUp(email, password);

                                    // if (user != null) {
                                    //   print("Kayıt başarılı: ${user.email}");
                                    // } else {
                                    //   print("Kayıt başarısız");
                                    // }
                                  },
                                  child: const Text(
                                    _registerText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
