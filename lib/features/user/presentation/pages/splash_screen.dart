import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double? _progress = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {
      Timer.periodic(const Duration(milliseconds: 50), (timer) {
        if (_progress! < 1) {
          setState(() {
            _progress = _progress! + 0.01;
          });
        } else {
          timer.cancel();
          Navigator.pushReplacementNamed(context, "/login");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    "assets/icons/gifs/splashscreen.gif",
                    fit: BoxFit.cover,
                    color: HexColor("7a67f3"),
                  ),
                ),
              ),
              Positioned(
                bottom: 40,
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: LinearProgressIndicator(
                    minHeight: 10,
                    value: _progress,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(HexColor("7a67f3")),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
