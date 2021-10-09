import 'package:flutter/material.dart';

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CineBMS Oh Snap!'),
      ),
      body: const Center(
        child: Text('Something is wrong! Try Again Later.'),
      ),
    );
  }
}
