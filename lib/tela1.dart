import 'package:flutter/material.dart';
import 'package:connectus/main.dart';
import 'package:connectus/tela2.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';

class Tela1 extends StatefulWidget {
  @override
  State<Tela1> createState() => _Tela1State();
}

class _Tela1State extends State<Tela1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(
        milliseconds: 1500,
      ),
      () => Navigator.of(context).pushReplacement(
        PageTransition(
          type: PageTransitionType.fade, // Tipo de animação (pode ser alterado)
          duration: Duration(milliseconds: 800), // Duração da animação
          child: Tela2(),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF191E41),
            const Color(0xFF394CC8),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(child: AppAssets.logoconnectusbr),
            ),
          ],
        ),
      ),
    );
  }
}
