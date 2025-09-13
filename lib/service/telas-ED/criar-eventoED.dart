import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectus/service/emp_login_service.dart';
import 'package:connectus/service/telas-ED/info-eventoED.dart';
import 'package:flutter/material.dart';
import 'package:connectus/tela2.dart';
import 'package:page_transition/page_transition.dart';

class CriareventED extends StatefulWidget {
  @override
  State<CriareventED> createState() => _CriareventEDState();
}

class _CriareventEDState extends State<CriareventED> {
  final AuthService _authService = AuthService();
  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();
  final _nomeEVController = TextEditingController();
  final _descEVController = TextEditingController();
  final List<Widget> _carrosselItens = [];

  int _contaitens = 0;

  void addNewContainer() {
    setState(() {
      _contaitens++;
      _carrosselItens.add(
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                child: InfoEV(),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 550),
              ),
            );
          },
          child: Container(
            height: 200,
            width: 250,
            child: Center(
                child: Text(
              'Evento Númeoro $_contaitens',
              style: TextStyle(color: Colors.white),
            )),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF191E41),
            Color(0xFF39A2C8),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
          title: Image.asset(
            'images/logo.png',
            height: 75,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: Image.asset(
                  'images/icone-viking.png',
                ),
                iconSize: 75,
                onPressed: () {
                  /* Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => TelaCO())); */
                },
              ),
            ),
          ],

          /* leading: Icon(Icons.email), para inserir um icone sem nada */
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(
                  context, MaterialPageRoute(builder: (context) => Tela2()));
            },
          ),

          /*  Iconbutton(
            icon: Icon(
              Icons.email,
            ),
          ), */
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                            child: Text(
                              'Crie seu evento', // puxa aqui o nome que ta na conta
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                                fontFamily: 'Iceberg',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(),
                    ),
                  ]),
                  SizedBox(
                    height: 55,
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      height: 200,
                      viewportFraction:
                          0.9, // Aumente para itens mais próximos (0.8 a 1.0)
                      // padEnds: false,
                    ),
                    items: _carrosselItens,
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  ElevatedButton(
                    onPressed: addNewContainer,
                    child: Text('+',
                        style: TextStyle(
                            fontFamily: 'Iceberg',
                            fontSize: 100,
                            color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      /* 
                  decoration: BoxDecoration(shape: BoxShape.circle),
                    shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(50), // Set the radius here
                  ), */
                      backgroundColor: Color(0xFF779EA9),
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//Container( color: Colors.white, height: 100, width: 100, ),
