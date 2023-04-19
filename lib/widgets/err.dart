import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Err extends StatelessWidget {
  const Err({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(25),
          width: 150,
          height: 150,
          child: Image.asset('assets/img/error.png'),
        ),
        const Text(
          "Server is Offline",
          style: TextStyle(
              fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 2,
        ),
        const Text("Try Again Later!")
      ],
    );
  }
}
