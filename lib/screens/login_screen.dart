import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//
import '../widgets/my_button.dart';
import 'welcome_screen.dart';
import 'chat_screen.dart';
import '../constants.dart' show kTextInputDecoration;

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: loading
            ? const CircularProgressIndicator()
            : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 180,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                const Text('Login Screen'),
                SizedBox(
                  width: screenWidth * .8,
                  child: TextField(
                    onChanged: (value) => setState(() => email = value),
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        kTextInputDecoration.copyWith(hintText: 'your email'),
                  ),
                ),
                const SizedBox(height: 12.0),
                SizedBox(
                  width: screenWidth * .8,
                  child: TextField(
                    obscureText: true,
                    onChanged: (value) => setState(() => password = value),
                    decoration: kTextInputDecoration.copyWith(
                        hintText: 'your password'),
                  ),
                ),
                const SizedBox(height: 24.0),
                MyButton(
                    text: 'Login',
                    onPressed: () async {
                      setState(() => loading = true);
                      print('email: $email, password: $password');
                      try {
                        final newUser = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (newUser != null) {
                          Navigator.of(context)
                              .popAndPushNamed(ChatScreen.routeName);
                        }
                        setState(() => loading = false);
                      } catch (e) {
                        print(e);
                      }
                    })
              ]),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Navigator.of(context).popAndPushNamed(WelcomeScreen.routeName)),
    );
  }
}
