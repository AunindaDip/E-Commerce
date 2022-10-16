

import 'package:flutter/material.dart';

import 'login.dart';

class splashscreen extends StatefulWidget {
  const splashscreen ({Key? key}) : super(key: key);
  @override
  _splashscreenState createState() => _splashscreenState();

  }
class _splashscreenState extends State<splashscreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatelogin();
  }
  _navigatelogin()async
  {
await Future.delayed(const Duration(milliseconds: 1500),(){});
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => const login()),
);
  }


  @override
  Widget build(BuildContext context){
  return Scaffold(
    body: Center(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/dip.jpg'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    ),
  );

  }}