import 'package:flutter/material.dart';

class RelatorioED extends StatefulWidget {
  final List<String> leituras;

  const RelatorioED({Key? key, required this.leituras}) : super(key: key);

  @override
  State<RelatorioED> createState() => _RelatorioEDState();
}

class _RelatorioEDState extends State<RelatorioED> {
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                    child: Text('Relatório', style: TextStyle(color: Colors.white),)),
              ),
              Image.asset(
                'images/logo.png',
                height: 75,
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Registrados: ',
              style: TextStyle(fontSize: 30, color: Colors.white),),
              Container(
                height:300,
                width: 377,
                decoration: BoxDecoration(
                    color: Color(0xFF779EA9),
                  borderRadius: BorderRadius.all(Radius.circular(10)),),
                child: ListView.builder(
                  itemCount: widget.leituras.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF779EA9),
                        borderRadius: BorderRadius.all(Radius.circular(10)
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.check_circle_outline,
                        color: Colors.white),
                        title: Text('Aluno ${index + 1}',
                          style: TextStyle(
                              color: Colors.white,
                          fontSize: 25),
                        ),
                        subtitle: Text(widget.leituras[index],
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}