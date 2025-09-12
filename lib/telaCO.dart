import 'dart:convert';
import 'package:connectus/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'service/eventoCO.dart';

class TelaCO extends StatefulWidget {
  @override
  State<TelaCO> createState() => _TelaCOState();
}

class _TelaCOState extends State<TelaCO> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.post(
          //10.68.101.235 IP máqina da escola
          //10.0.2.2 IP do emulador android
          //localhost IP para navegador web

            Uri.parse('http://10.68.101.235/bifrost/verific.php'),
            //headers: {'Content-type': 'application/json'}, //isso é pra funcionar com o json
            body: //jsonEncode( //isso é pra funcionar com o json
            {
              'email': _emailController.text,
              'senha': _senhaController.text,
            } //), //isso é pra funcionar com o json
        );
        print("resposta recebida ${response.body}");
        final data = jsonDecode(response.body);
        if (data ['success']) {
          print("login fazido");
          Navigator.push(
            context,
            PageTransition(
              child: EventCO(),
              type: PageTransitionType.fade,
              duration: Duration(milliseconds: 550),
            ),
          );
        }


        else {
          print("login deu errado");

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'])),
          );
        }
      } catch (k) {
        print("erro na requisição $k");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("erro com server")),
        );
      }
    } else { print("validação do form");}

  }

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
          centerTitle: true,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
          title: Image.asset(
            'images/logo.png',
            height: 75,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(
                context,
                PageTransition(
                  child: TelaCO(),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 550),
                ),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Login do administrador',
                          style: TextStyle(
                            fontSize: 50,
                            fontFamily: 'Iceberg',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Text('Insira os dados de login do administrador',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Iceberg',
                          color: Colors.white60,
                        )),
SizedBox(height:25,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40,0,40,0),
          
          
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,),
                              child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: ' Insira seu Email',
                                  labelText: ' Email',
                                  labelStyle: TextStyle( color: Color(0xFF5839C8),),   ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '  Insira seu email'; //verifica se o email ta vazio
                                  }
                                  if (!value.contains('@')){
                                    return 'Email inválido'; //vê se realmente é um email
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20
                              ,),
                            SizedBox(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white,),
                                child: TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: _senhaController,
                                  decoration: InputDecoration(
                                    hintText: ' Insira sua senha',
                                    labelText: ' Senha',
                                    labelStyle: TextStyle( color: Color(0xFF5839C8),),),
                                  obscureText: false,
                                   validator: (value){
                                    if (value == null || value.isEmpty) {
                                      return '  Insira uma senha';
                                     }
                                    if (value.length < 6) {
                                      return 'Senha inválida';
                                    }
                                    return null;
                                   },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),

              ElevatedButton(
                onPressed: _login,
                child: Text('Entrar',
                    style: TextStyle(
                        fontFamily: 'Iceberg',
                        fontSize: 25,
                        color: Color(0xFF5839C8))),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
              // Container(child: AppAssets.montanha),
                ],
              ),
              // Container(child: AppAssets.montanha),
            ],
          ),
        ),
      ),
    );
  } //email: teste@ senha: 123456
  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }
}





//Container( color: Colors.white, height: 100, width: 100, ),
