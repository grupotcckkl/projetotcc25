import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectus/service/emp_login_service.dart';
import 'package:connectus/service/telas-ED/info-eventoED.dart';
import 'package:flutter/material.dart';
import 'package:connectus/tela2.dart';
import 'package:page_transition/page_transition.dart';

class EventED extends StatefulWidget {
  @override
  State<EventED> createState() => _EventEDState();
}
class _EventEDState extends State<EventED> {
  final AuthService _authService = AuthService();
  String? nomeEmp;
  bool isLoading = true;

  final List<Widget> _carrosselItens = [
//o contador ta pronto mas vou ter que mudar isso pro
// botão levar na tela de cadastro do evento e depois um botão lá adicionar um evento como nome bonitinho
    /* InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            child: EventCO(),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 550),
          ),
        );
      },
      child: Container(
        height: 200,
        width: 250,
        child: Center(child: Text('Evento Númeoro 0')),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),*/
  ];

  int _contaitens = 0;
@override
void initState(){
  super.initState();
  _loadEmpresaData();
}
Future<void> _loadEmpresaData() async {}

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
            child: Center(child: Text('Evento Númeoro $_contaitens',
              style: TextStyle(
                  color: Colors.white),)),
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
                              'Meus Eventos', // puxa aqui o nome que ta na conta
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
                              'Bem vindo(a)\n*variavel de nome*!!', // puxa aqui o nome que ta na conta
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Iceberg',
                                color: Colors.white70,
                              ),
                            ),
                          ),

                        ),
                      ),
                    ],
                  ),
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
                  /*  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ), */

                  //aqui no meio vai ficar o formulario
                  /* 
                  PopupMenuButton<String>(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'opcao1',
                        child: Text('Opção 1'),
                      ),
                      PopupMenuItem(
                        value: 'opcao2',
                        child: Text('Opção 2'),
                      ),
                      PopupMenuItem(
                        value: 'opcao3',
                        child: Text('Opção 3'),
                      ),
                    ],
                    onSelected: (value) {
                      print('Opção selecionada: $value');
                      // Adicione a ação para cada opção aqui
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Clique para menu',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ), */
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
