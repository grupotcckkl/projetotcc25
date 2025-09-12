import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectus/tela2.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class TelaCad extends StatefulWidget {
  @override
  State<TelaCad> createState() => _TelaCadState();
}

List<String> options = ['Corporativo', 'Educacional'];

class _TelaCadState extends State<TelaCad> {
  String currentOptinon = options[1];
  final _formKey = GlobalKey<FormState>();
  final _nomeinstController = TextEditingController();
  final _emailinstController = TextEditingController();
  final _senhainstController = TextEditingController();
  final _telController = TextEditingController();
  int? _tipoController; //preciso adicionar um controlador para o tipo


  Future<void> _cadastro() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.post(
          //10.68.101.235 IP máqina da escola
          //10.0.2.2 IP do emulador android
          //localhost IP para navegador web

          Uri.parse('http://10.68.101.235/bifrost/conexaocadinst.php'),
          headers: {
            'Content-type': 'application/json'
          }, //isso é pra funcionar com o json
          body: jsonEncode(//isso é pra funcionar com o json
              {
            'nome_emp': _nomeinstController.text,
            'tel_emp': _telController.text,
            'email_emp': _emailinstController.text,
            'tipo_inst': _tipoController,
            'senha_emp': _senhainstController.text,
          }), //isso é pra funcionar com o json
        );

        // print("resposta recebida ${response.body}");
        // print("STATUS: ${response.statusCode}");
        // print("BODY: ${response.body}");
        final data = jsonDecode(response.body);
        if (data['success']) {
          print("cadastro realizado");
          Navigator.push(
            context,
            PageTransition(
              child: Tela2(),
              type: PageTransitionType.fade,
              duration: Duration(milliseconds: 550),
            ),
          );
        } else {
          print("cadastro deu errado: ${data['message']}");

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
    } else {
      print("validação do form");
    }
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
                  child: Tela2(),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 550),
                ),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    // Center(
                    //
                    //     child: Text(
                    //         'Connect Us',
                    //         style: TextStyle(
                    //           fontSize: 50,
                    //           fontFamily: 'Iceberg',
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Text(
                        'Cadastre-se para ter mais segurança e confiança',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Iceberg',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Color(0xFFF5F5F5),
                                      ),
                                      child: TextFormField(
                                        keyboardType: TextInputType.name,
                                        controller: _nomeinstController,
                                        decoration: InputDecoration(
                                          hintText:
                                              ' Insira seu o nome da sua empresa',
                                          labelText: ' Nome',
                                          labelStyle: TextStyle(
                                            color: Color(0xFF394CC8),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '  campo obrigatório'; //verifica se o email ta vazio
                                          }

                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 0, 20, 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Color(0XFFF5F5F5),
                                      ),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        controller: _telController,
                                        decoration: InputDecoration(
                                          hintText:
                                              ' Insira somente os números sem código do país',
                                          labelText: ' Telefone',
                                          labelStyle: TextStyle(
                                            color: Color(0xFF394CC8),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '  campo obrigatório';
                                          }
                                          if (value.length < 10) {
                                            return 'número inválido';
                                          }
                                          if (value.length > 11) {
                                            return 'número inválido';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 0, 20, 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Color(0XFFF5F5F5),
                                      ),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              ' Qual o tipo da sua empresa?',
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'Iceberg',
                                                color: Color(0xFF394CC8),
                                              ),
                                            ),
                                          ),
                                          RadioListTile<int>(
                                            title: Text('Escola'),
                                            value: 1,
                                            groupValue: _tipoController,
                                            onChanged: (value) {
                                              setState(() {
                                                _tipoController = value;
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            height: 0,
                                          ),
                                          RadioListTile<int>(
                                            title: Text('Corporativo'),
                                            value: 2,
                                            groupValue: _tipoController,
                                            onChanged: (value) {
                                              setState(() {
                                                _tipoController = value;
                                              });
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 0, 20, 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Color(0XFFF5F5F5),
                                      ),
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: _emailinstController,
                                        decoration: InputDecoration(
                                          hintText: ' Insira seu email',
                                          labelText: ' Email',
                                          labelStyle: TextStyle(
                                            color: Color(0xFF394CC8),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '  campo obrigatório';
                                          }
                                          if (!value.contains('@')) {
                                            return 'Email inválido';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 0, 20, 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Color(0XFFF5F5F5),
                                      ),
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        controller: _senhainstController,
                                        decoration: InputDecoration(
                                          hintText: ' Insira sua senha',
                                          labelText: ' Senha',
                                          labelStyle: TextStyle(
                                            color: Color(0xFF394CC8),
                                          ),
                                        ),
                                        obscureText: true,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '  campo obrigatório';
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
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    ElevatedButton(
                      onPressed: _cadastro,
                      child: Text('Cadastrar',
                          style: TextStyle(
                              fontFamily: 'Iceberg',
                              fontSize: 25,
                              color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
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
      ),
    );
  }
}
