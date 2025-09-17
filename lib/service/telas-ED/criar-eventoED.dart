import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectus/service/emp_login_service.dart';
import 'package:connectus/service/telas-ED/info-eventoED.dart';
import 'package:flutter/material.dart';
import 'package:connectus/tela2.dart';
import 'package:page_transition/page_transition.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CriareventED extends StatefulWidget {
  @override
  State<CriareventED> createState() => _CriareventEDState();
}

class _CriareventEDState extends State<CriareventED> {
  final AuthService _authService = AuthService();
  bool isLoading = true;
  //controlador do nome do evento
  final _nomeEVController = TextEditingController();

  //controlador da descrição do evento
  final _descEVController = TextEditingController();

  //controlador do id da empresa
  final _id_empController = TextEditingController();

  //controlador do tipo do evento
  final _tipo_ctrlController = TextEditingController();

  final SupabaseClient _supabase = Supabase.instance.client;
  final List<Widget> _carrosselItens = [];
  bool _isLoading = false;

  //função que envia os dados do evento para o banco:
  Future <void> _cadastrarEvento() async{
    String nomeEV = _nomeEVController.text.trim();
    String descEV = _descEVController.text.trim();
    String id_emp = _id_empController.text.trim();
    String  tipo_ctrl = _tipo_ctrlController.text.trim();

    //vÊ se ta tudo preenchido
    if (nomeEV.isEmpty || descEV.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              'Por favor, preencha todos os campos',
            style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.yellow),
      );
      return;
    }
    setState(() {
      _isLoading = true;
    });

    //envia os dados de verdade para o banco
    try {
      await _supabase.from('evento').insert({
        'nome': nomeEV,
        'descricao': descEV,
        'id_emp': id_emp,
        'tipo_ctrl': tipo_ctrl,
      });
     if (mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
              'Conteiner criado :D',
            ),
            backgroundColor: Colors.green),
      );
    }
     _nomeEVController.clear();
     _descEVController.clear();
    } catch(erro){
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(     //linha com erro é só para testes deve ser retirada na versão final pq mostrar os erros que tem por usuário tem que ter "deu errado :/"
            content: Text('erro ao conectar: ${erro.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    //função para ficar mais facil de chamar as menssagem, por algum motivo não funcionou e tive que fazer manual kkkkk

    // void _mostrarMensagem(String mensagem, Color cor) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(mensagem),
    //       backgroundColor: cor,
    //       duration: Duration(seconds: 3),
    //     ),
    //   );
    // }
  }

  int _contaitens = 0;
//função para adicionar o container isso vou nusar com os dados do formulairo que vou jogar no banco

  // void addNewContainer() {
  //   setState(() {
  //     _contaitens++;
  //     _carrosselItens.add(
  //       InkWell(
  //         onTap: () {
  //           Navigator.push(
  //             context,
  //             PageTransition(
  //               child: InfoEV(),
  //               type: PageTransitionType.fade,
  //               duration: Duration(milliseconds: 550),
  //             ),
  //           );
  //         },
  //         child: Container(
  //           height: 200,
  //           width: 250,
  //           child: Center(
  //               child: Text(
  //             'Evento Númeoro $_contaitens',
  //             style: TextStyle(color: Colors.white),
  //           )),
  //           decoration: BoxDecoration(
  //             color: Colors.white.withOpacity(0.2),
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //         ),
  //       ),
  //     );
  //   });
  // }

//limpa a memoria quando fechar a tela
  @override
  void dispose() {
    _nomeEVController.dispose();
    _descEVController.dispose();
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
                  //deslogar (preciso adicionar ainda 17-09)
                  /* Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => TelaCO())); */
                },
              ),
            ),
          ],

          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(
                  context, MaterialPageRoute(builder: (context) => Tela2()));
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                            child: Text(
                              'Crie seu evento',
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
                      Text('Insira os dados do evento',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Iceberg',
                            color: Colors.white60,
                          )),
                    ],
                  ),
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(),
                    ),
                  ]),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: TextField(
              cursorColor: Color(0xFF779EA9),
              controller: _nomeEVController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Titulo',
                hintText: 'Digite o titulo do evento',
                hintStyle: TextStyle(color: Colors.white70),
                labelStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.person, color: Color(0xFF779EA9)),
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
          //campo para adicionar o nome do evento

          SizedBox(height: 12,),

                  //campo para adicionar a descrição do evento
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      cursorColor: Color(0xFF779EA9),
                      controller: _descEVController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Descrição',
                        hintText: 'Digite a descrição do evento',
                        hintStyle: TextStyle(color: Colors.white70),
                        labelStyle: TextStyle(color: Colors.white70),
                        prefixIcon: Icon(Icons.edit, color: Color(0xFF779EA9)),
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
                  SizedBox(height: 12,),
                  //campo para adicionar o tipo do evento
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      cursorColor: Color(0xFF779EA9),
                      controller: _tipo_ctrlController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Tipo Evento',
                        hintText: '1) educaional  2) corporativo',
                        hintStyle: TextStyle(color: Colors.white70),
                        labelStyle: TextStyle(color: Colors.white70),
                        prefixIcon: Icon(Icons.school, color: Color(0xFF779EA9)),
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
                  SizedBox(height: 12,),

                  //campo para adicionar a descrição do evento
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      cursorColor: Color(0xFF779EA9),
                      controller: _id_empController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Pin',
                        hintText: 'Digite o pin da sua empresa',
                        hintStyle: TextStyle(color: Colors.white70),
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

                  SizedBox(height: 12,),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _cadastrarEvento, // Desabilita se estiver carregando
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF6FDFF),
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
                        'Cadastrar',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF39A2C8),
                        ),
                      ),
                    ),
                  ),

                  //carrol dos conteiners
                  // CarouselSlider(
                  //   options: CarouselOptions(
                  //     enableInfiniteScroll: false,
                  //     height: 200,
                  //     viewportFraction:
                  //         0.9, // Aumente para itens mais próximos (0.8 a 1.0)
                  //     // padEnds: false,
                  //   ),
                  //   items: _carrosselItens,
                  // ),

                  //botão que cria os conteiners
                  // ElevatedButton(
                  //   onPressed: null,//addNewContainer,
                  //   child: Text('Criar',
                  //       style: TextStyle(
                  //           fontFamily: 'Iceberg',
                  //           fontSize: 100,
                  //           color: Colors.white)),
                  //   style: ElevatedButton.styleFrom(
                  //     shape: CircleBorder(),
                  //     backgroundColor: Color(0xFF779EA9),
                  //     padding:
                  //         EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  //   ),
                  // ),
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
