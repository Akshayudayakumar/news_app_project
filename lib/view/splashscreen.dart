import 'package:flutter/material.dart';
import 'package:news_app_project/widgets/app_name.dart';

import 'loginscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
Future.delayed(Duration(seconds: 2)).then((value) => getData());
  }
  getData(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body: Center(
      child: AppName(),
      ),
      ),
    );
  }
}
