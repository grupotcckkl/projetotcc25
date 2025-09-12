import 'package:connectus/tela2.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../emp_login_service.dart';
import 'eventoED.dart';

class LoginED extends StatefulWidget {
  LoginED({super.key});

  @override
  State<LoginED> createState() => _LoginED();
}

class _LoginED extends State<LoginED> {
  final authService = AuthService();
  bool _isLoading = false;

  // Controllers
  final _emailInstController = TextEditingController();
  final _senhaInstController = TextEditingController();

  // botão de login quando pressionado
  void login() async {
    final email = _emailInstController.text.trim();
    final senha = _senhaInstController.text;

    // Validação básica
    if (email.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              'Por favor, preencha todos os campos',
            ),
            backgroundColor: Colors.red),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // tenta logar
    try {
      final empresaData =
      await authService.singInWithEmailPassword(email, senha);

      // Login bem-sucedido, mostra mensagem e navega
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login realizado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navega para a tela principal ou força rebuild do AuthGate
        Navigator.of(context).pushReplacement(
          PageTransition(
            type:
            PageTransitionType.fade, // Tipo de animação (pode ser alterado)
            duration: Duration(milliseconds: 800), // Duração da animação
            child: EventED(), //Tela1(),
          ),
          /*
          MaterialPageRoute(builder: (BuildContext context) => Tela1()) */
        ); // ou sua rota principal
      }
    } catch (k) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(     //linha com k é só para testes deve ser retirada na versão final
            content: Text('erro ao conectar: ${k.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailInstController.dispose();
    _senhaInstController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF191E41), //cor padrão
            const Color(0xFF39A2C8), //cor variavel
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
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),

              // Título
              Container(
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

              SizedBox(height: 20),

              // Subtítulo
              Text('Insira os dados de login da sua instituição',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Iceberg',
                    color: Colors.white60,
                  )),

              SizedBox(height: 40),

              // Campo de Email
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  cursorColor: Color(0xFF779EA9),
                  controller: _emailInstController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Email da Instituição',
                    labelStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.email, color: Color(0xFF779EA9)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ),

              // Campo de Senha
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  cursorColor: Color(0xFF779EA9),
                  controller: _senhaInstController,
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF779EA9)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              // Botão de Login
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF191E41),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Color(0xFF191E41)),
                  )
                      : Text(
                    'Entrar',
                    style: TextStyle(
                      color: Color(0xFF39A2C8),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
