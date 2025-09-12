import 'package:flutter/material.dart';

class RelatorioCO extends StatefulWidget {
  final List<String> leituras;

  const RelatorioCO({Key? key, required this.leituras}) : super(key: key);

  @override
  State<RelatorioCO> createState() => _RelatorioCOState();


}

class _RelatorioCOState extends State<RelatorioCO> {
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
            const Color(0xFF5839C8),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Color(0xFF7779A9),
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
                  color: Color(0xFF7779A9),
                  borderRadius: BorderRadius.all(Radius.circular(10)),),
                child: ListView.builder(
                  itemCount: widget.leituras.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF7779A9),
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