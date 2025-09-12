import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:crypto/crypto.dart';
class AuthService{
  final SupabaseClient _supabase = Supabase.instance.client;

  Map<String, dynamic> ? _currentEmpresa;

  Map<String, dynamic>? get currentEmpresa => _currentEmpresa;

  //login com email e senha
  Future<Map<String, dynamic>> singInWithEmailPassword(String email, String password) async {

   try {
     final response = await _supabase
         .from('empresa')
         .select()
         .eq('email_emp', email.toLowerCase().trim())
         .eq('senha', password) // Use hashedPassword se estiver usando hash
         .single();
     if (response != null) {
       //salva os dados da inst
       _currentEmpresa = response;

       return response;
     } else {
       throw Exception('Credenciais inválidas');
     }
   } catch (k){
     if (k.toString().contains('JSON object requested, multiple (or no) rows returned')) {
       throw Exception('Credenciais inválidas');
     }
     throw Exception('Erro ao fazer login: ${k.toString()}');
   }
   }
  //log out ainda usando o emial e a senha
Future<Map<String, dynamic>> signUpWithEmailPassword (
    String email_emp,
    String senha,
  {Map<String, dynamic>? additionalData}
    ) async {
    try{
      final existingUser = await _supabase
          .from('empresa')
          .select('email_emp')
          .eq('email_emp', email_emp.toLowerCase().trim());
      if (existingUser.isNotEmpty){
        throw Exception('Email já cadastrado');
      }
      final empresaData = {
        'email': email_emp.toLowerCase().trim(),
        'senha': senha, // Use _hashPassword(password) se quiser hash
        'created_at': DateTime.now().toIso8601String(),
        ...?additionalData, // Dados adicionais da empresa
      };

      final response = await _supabase
          .from('empresa')
          .insert(empresaData)
          .select()
          .single();

      return response;
    } catch(k) {
      throw Exception('Erro ao cadastrar: ${k.toString()}');
    }
  }

  //sair
Future<void> signOut() async {
    _currentEmpresa = null;
    await _clearSession();
}

//vê se está logado
  bool isLoggedIn() {
    return _currentEmpresa != null;
  }//pega o email
  String? getCurrentUserEmail() {
    return _currentEmpresa?['email_emp'];
  }
  //pega o nome
  String? getCurrentEmpresaNome() {
    return _currentEmpresa?['nome_emp'] ?? _currentEmpresa?['razao_social'];
  }
  //pega o id
  String? getCurrentEmpresaId() {
    return _currentEmpresa?['id_emp']?.toString();
  }


  Future<void> _saveSession(Map<String, dynamic> empresaData) async {
    // Aqui você pode usar SharedPreferences para persistir a sessão
    // Por simplicidade, vamos apenas manter em memória
    _currentEmpresa = empresaData;
  }

  // Limpa sessão local
  Future<void> _clearSession() async {
    _currentEmpresa = null;
    // Limpar também do SharedPreferences se estiver usando
  }

  Future<void> loadSession() async {
    // Aqui você carregaria do SharedPreferences
    // Por ora, deixamos null (usuário precisa fazer login toda vez)
    _currentEmpresa = null;
  }
  Future<Map<String, dynamic>> updateEmpresaData(Map<String, dynamic> updates) async {
    if (_currentEmpresa == null) {
      throw Exception('Nenhuma empresa logada');
    }
    final id_emp = _currentEmpresa!['id'];

    final response = await _supabase
        .from('empresa')
        .update(updates)
        .eq('id', id_emp)
        .select()
        .single();

    _currentEmpresa = response;
    await _saveSession(response);

    return response;
  }
}