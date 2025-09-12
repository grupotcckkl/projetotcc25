import 'dart:async';
import 'package:connectus/service/telas-ED/eventoED.dart';
import 'package:connectus/tela1.dart';
import 'package:flutter/material.dart';
import 'package:connectus/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
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
          child: Tela1(), //Tela1(),
        ),
        /* 
          MaterialPageRoute(builder: (BuildContext context) => Tela1()) */
      ),
    );
  }

  @override
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
              child: InkWell(
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'images/logobifrostbr.svg',
                            height: 250,
                            alignment: Alignment.bottomCenter,
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
