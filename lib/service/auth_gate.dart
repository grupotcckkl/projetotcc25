import 'package:connectus/service/eventoCO.dart';
import 'package:connectus/service/testsupa.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'emp_login_service.dart';
import 'Login-Inst-CO.dart';

class Authgate extends StatefulWidget {
  @override
  State<Authgate> createState() => _AuthgateState();
}

class _AuthgateState extends State<Authgate> {
  final AuthService _authService = AuthService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  //se tudo funcionar carrega a sessão slava
  Future<void> _checkAuthStatus() async {
    await _authService.loadSession();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Verifica se está logado
    if (_authService.isLoggedIn()) {
      return EventCO();
    } else {
      return Loginteste();
    }
  }
}
