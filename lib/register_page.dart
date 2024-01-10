import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
    const String _hintText = 'Kullanıcı Adı';
    const String _hintTextPassword = 'Şifre';
    const String _loginIn = 'Giriş';
    const String _isMember = 'Hala üye değil misiniz?';
    const String _registerText = 'Kayıt ol';

    return Scaffold(
      backgroundColor: Colors.amber,
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
                          onPressed: () async {
                            String email = _emailController.text;
                            String password = _passwordController.text;

                            User? user = await signUp(email, password);

                            if (user != null) {
                              print("Kayıt başarılı: ${user.email}");
                            } else {
                              print("Kayıt başarısız");
                            }
                          },
                          child: const Text(_loginIn),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _isMember,
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
