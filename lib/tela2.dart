import 'package:connectus/cadastro.dart';
import 'package:connectus/service/auth_gate.dart';
import 'package:connectus/service/telas-CO/loginCO.dart';
import 'package:connectus/service/telas-ED/loginED.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

class Tela2 extends StatelessWidget {
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
         appBar: AppBar(
           centerTitle: true,
           backgroundColor: Colors.transparent,
           title:
           Image.asset(
             'images/logo.png',
             height: 75,
           ),
         ),
        body:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                    'images/logobrconnectus.svg',
                  height: 150,
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            const Text(
              'Qual o tipo da sua conta?',
              style: TextStyle(
                fontSize: 35,
                fontFamily: 'Iceberg',
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: Authgate(),
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 550),
                        ),
                      );
                      // Ação ao pressionar o botão
                    },
                    child: const Text('Corporativo',
                        style: TextStyle(
                          color: Color(0xFF5839C8),
                          fontSize: 25,
                          fontFamily: 'Iceberg',
                        )),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  /*  SizedBox(
                      height: 25,
                    ), */
                  Text(
                    'ou',
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: LoginED(),
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 550),
                        ),
                      );
                      // Ação ao pressionar o botão
                    },
                    child: Text('Educacional',
                        style: TextStyle(
                          color: Color(0xFF39A2C8),
                          fontSize: 25,
                          fontFamily: 'Iceberg',
                        )),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: TelaCad(),
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 550),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white60,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'Iceberg',
                        )),
                    child: Text('Cadastre-se'),
                  ),
                ],
              ),
            ),

            // Container(child: AppAssets.montanha),
          ],
        ),

      ),
    );
  }
}
//Container( color: Colors.white, height: 100, width: 100, ),
