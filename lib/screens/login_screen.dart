import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_services.dart';




class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('CineBMS Login'),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Login with",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              IconButton(
                icon: const Icon(FontAwesomeIcons.google),
                color: Colors.deepOrangeAccent,
                iconSize: 60.0,
                onPressed: _onGoogleIconPressed,
              ),
              IconButton(
                icon: const Icon(FontAwesomeIcons.facebook),
                color: Colors.blue,
                iconSize: 60.0,
                onPressed: _onFacebookIconPressed,
              ),
            ],
          )
      ),
    );
  }

  void _onFacebookIconPressed() async{
    UserCredential? userCredential = await signInWithFacebook();
    _shouldRoute(userCredential);
  }

  void _onGoogleIconPressed() async{
    UserCredential? userCredential = await signInWithGoogle();
    _shouldRoute(userCredential);
  }

  void _shouldRoute(UserCredential? userCredential) {
    if(userCredential != null){
      if(userCredential.user != null){
        Navigator.pushReplacementNamed(context, 'FeedScreen');
      }
    }
  }
}








