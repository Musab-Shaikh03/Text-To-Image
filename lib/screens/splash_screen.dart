import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:major_project/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: ((context) => const MyHomePage()),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Stack(
            children: [
              Container(
                width: 250,
                height: 250,
                // child: Lottie.network(
                //     'https://assets3.lottiefiles.com/packages/lf20_fhy1wvb1.json'),
                child:
                    Lottie.asset('assets/img/92353-setting-mobile-phone.json'),
              ),
              Container(
                width: 250,
                height: 250,
                // child: Lottie.network(
                //     'https://assets9.lottiefiles.com/datafiles/4RCaFB2gSGhln4YXVKAu2EXSnDIt9ZszBeAW2fYQ/ModernPictogramsForLottie_Text.json'),
                child: Lottie.asset('assets/img/749-text.json'),
              ),
            ],
          ),
        ),
        const Text(
          'G.A.N',
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Generate Image By Just Using Descriptive Text!',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        )
      ]),
    );
  }
}
