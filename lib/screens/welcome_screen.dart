import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
//
import '../widgets/my_button.dart';
import 'registration_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = '/welcome';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.addListener(() {
      setState(() {});
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 1.0);
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(
          (34.0 + (controller.value * 200)).round(),
          (78 + (controller.value * 120)).round(),
          (243 - (controller.value * 100)).round(),
          1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                      tag: 'logo',
                      child: SizedBox(
                          child: Image.asset('images/logo.png'),
                          height: animation.value * 60.0)),
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 30.0,
                      // fontFamily: 'Agne',
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText("Flash Chat"),
                        TypewriterAnimatedText(
                          'Chat with friends...',
                          speed: const Duration(milliseconds: 100),
                          cursor: '|',
                        ),
                        FadeAnimatedText('Make someone\'s day...'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 30),
                ],
              ),
            ),
            const SizedBox(height: 60),
            MyButton(
              onPressed: () =>
                  Navigator.of(context).popAndPushNamed(LoginScreen.routeName),
              text: 'Login',
              buttonColor: Colors.blue.shade900,
            ),
            MyButton(
              onPressed: () => Navigator.of(context)
                  .popAndPushNamed(RegistrationScreen.routeName),
              text: 'Register',
              buttonColor: Colors.red.shade200,
            ),
          ],
        ),
      ),
    );
  }
}
