import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//
import 'screens/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
            textTheme:
                const TextTheme(bodyText1: TextStyle(color: Colors.black54))),
        initialRoute: WelcomeScreen.routeName,
        routes: {
          WelcomeScreen.routeName: (context) => WelcomeScreen(),
          ChatScreen.routeName: (context) => ChatScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          RegistrationScreen.routeName: (context) => RegistrationScreen(),
        });
  }
}
