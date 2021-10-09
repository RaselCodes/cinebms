import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CineBMS Loading'),
      ),
      body: const Center(
        child: CircularProgressIndicator(
          value: null,
        ),
      ),
    );
  }
}
