import 'package:connectus/telaCO.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'emp_login_service.dart';

class LogininstCO extends StatefulWidget {
  @override
  State<LogininstCO> createState() => _LogininstCOState();
}

class _LogininstCOState extends State<LogininstCO> {
  final _formKey = GlobalKey<FormState>();
  final _emailInstController = TextEditingController();
  final _senhaInstController = TextEditingController();
  final SupabaseClient _supabase = Supabase.instance.client;
  bool _carregando = false;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _carregando = true);
      try {
        final response = await _supabase
            .from('empresa')
            .select()
            .eq('email_emp', _emailInstController.text)
            .eq('senha', _senhaInstController.text)
            .maybeSingle();
        if (response != null) {
          print("login da Inst fazido");
          Navigator.push(
            context,
            PageTransition(
              child: TelaCO(),
              type: PageTransitionType.fade,
              duration: Duration(milliseconds: 550),
            ),
          );
        } else {
          print("login da Inst deu errado");

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("email ou senha incorretos")),
          );
        }
      } catch (k) {
        print("erro na requisição $k");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("erro com server")),
        );
      } finally {
        setState(() => _carregando = false);
      }
    } else {
      print("validação do form Inst");
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Container(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Login da Instituição',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 50,
                            fontFamily: 'Iceberg',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Text('Insira os dados de login da sua instituição',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Iceberg',
                        color: Colors.white60,
                      )),
                  SizedBox(
                    height: 25,
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
                            child: TextFormField(
                              controller: _emailInstController,
                              decoration: InputDecoration(
                                hintText: ' Insira seu Email',
                                labelText: ' Email',
                                labelStyle: TextStyle(
                                  color: Color(0xFF5839C8),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '  Insira seu email'; //verifica se o email ta vazio
                                }
                                if (!value.contains('@')) {
                                  return 'Email inválido'; //vê se realmente é um email
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                controller: _senhaInstController,
                                decoration: InputDecoration(
                                  hintText: ' Insira sua senha',
                                  labelText: ' Senha',
                                  labelStyle: TextStyle(
                                    color: Color(0xFF5839C8),
                                  ),
                                ),
                                obscureText: false,
                                validator: (value) {
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

                  _carregando
                      ? CircularProgressIndicator(color: Colors.white)
                      : ElevatedButton(
                          onPressed: _carregando ? null : _login,
                          child: Text(
                            'entrar',
                            style: TextStyle(
                                fontFamily: 'iceberg',
                                fontSize: 25,
                                color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                          ),
                        )
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

  @override
  void dispose() {
    _emailInstController.dispose();
    _senhaInstController.dispose();
    super.dispose();
  }
}
