import 'package:connectus/service/telas-ED/relatorioED.dart';
import 'package:connectus/tela2.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';


class InfoEV extends StatefulWidget {
  @override
  State<InfoEV> createState() => _InfoEVState();
}

class _InfoEVState extends State<InfoEV> {
  String ticket = "";
  List<String> leituras =[];
  readQrcode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
      "#FF779EA9",
      "Voltar",
      true,
      ScanMode.QR,
    );
    if (code != '-1'){
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registro enviado para o Relatório")),
        );
        ticket = code;
        leituras.add(code);
      });
    }
    else{
      setState(()
         => ticket = "QR code não cadastrado"
      );
    }
    // setState(() => ticket * code != '-1' code : 'Não validado' );
  }
final controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF191E41), //const Color(0xFF191E41),
            // const Color(0xFF39A2C8),
            const Color(0xFF39A2C8),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Color(0xFF779EA9),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'images/logo.png',
                height: 75,
              ),
            ],
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(
                context,
                PageTransition(
                  child: Tela2(),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 550),
                ),
              );
            },
          ),
        ),
        body:
        SingleChildScrollView(


          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ElevatedButton(
                  //   onPressed: () => {}, child: Text('teste de validar'),
                  // ),
                  Container(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Evento 1',
                        style: TextStyle(
                          fontSize: 50,
                          fontFamily: 'Iceberg',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),


  //   Padding(padding:const EdgeInsets.fromLTRB(40,0,40,0),
  //                  child: MobileScanner(
  //                    onDetect: (capture) {},
  //                  )
  // ),
                  SizedBox(height: 15,),


                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Card(
                      color: Color(0xFF779EA9),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Descrição: ',  style: TextStyle(
                                  color: Colors.white,
                                    fontSize: 30,)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white,
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.black.withOpacity(0.2),
                                    //     spreadRadius: 2,
                                    //     blurRadius: 8,
                                    //     offset: Offset(0, 4), // deslocamento da sombra
                                    //   ),
                                    // ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text('Passeio no zoológico dia 20 de março.', style: TextStyle(fontSize: 20),),
                                  ),
                                height: 100,
                                width: 250,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF779EA9)
                                  ),
                                  label: Text('Scannear',
                                      style: TextStyle(color: Colors.white)),
                                  icon: Icon(Icons.qr_code_scanner,
                                  color: Colors.white),
                                  onPressed: readQrcode,
                                ),
                                SizedBox(width: 5,),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),

                  // if (ticket != '')
                  //   Padding(
                  //     padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  //     child: Text('Ticket: $ticket',
                  //       style: TextStyle(
                  //           fontSize: 15,
                  //           color: Colors.white),),
                  //   ),

                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF779EA9)
                        ),
                        label: Text('Relatório',
                            style: TextStyle(color: Colors.white, fontSize: 30)),
                        icon: Icon(Icons.edit_document,
                            color: Colors.white),
                        onPressed: (){
                          Navigator.push(
                            context,
                            PageTransition(
                              child: RelatorioED(leituras: leituras,),
                              type: PageTransitionType.fade,
                              duration: Duration(milliseconds: 550),
                            ),
                          );
                        }
                      ),
                      SizedBox(width: 10),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF779EA9)
                        ),
                        label: Text('Editar',
                            style: TextStyle(color: Colors.white, fontSize: 30)),
                        icon: Icon(Icons.edit,
                            color: Colors.white),
                        onPressed: readQrcode,
                      ),

                    ],
                  ),
                  // ListView.builder(
                  //   itemCount: leituras.length,
                  //   itemBuilder: (context, index) {
                  //     return ListTile(
                  //       leading: Icon(Icons.qr_code),
                  //       title: Text('Leitura ${index + 1}'),
                  //       subtitle: Text(leituras[index]),
                  //     );
                  //   },
                  // ),



                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(40,0,40,0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.all(Radius.circular(10)),
                  //       color: Colors.white,),
                  //     child: TextField(
                  //       // controller: _emailController,
                  //       decoration: InputDecoration(
                  //         hintText: ' o que você quer colocar no qr code',
                  //         labelText: ' qr code',
                  //         labelStyle: TextStyle( color: Color(0xFF5839C8),),
                  //         suffixIcon: IconButton(
                  //           color: Colors.black,
                  //           icon: Icon(Icons.done, size: 30),
                  //           onPressed: () => setState((){}
                  //           ),
                  //         )
                  //       ),
                  //     ),
                  //   ),
                  // ),



                  // ElevatedButton(
                  //   child: Text('text',
                  //   style: TextStyle(color: Color(0xFF39A2C8))),
                  //   onPressed: (){
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => Scanner()), );
                  // },  )
                  // Container(child: AppAssets.montanha),
                ],

              ),
              // Container(child: AppAssets.montanha),
            ],
          ),
        ),

      ),

    );
  }
  //email: teste@ senha: 123456
}





//Container( color: Colors.white, height: 100, width: 100, ),
