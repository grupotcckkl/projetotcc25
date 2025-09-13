import 'package:connectus/service/telas-ED/eventoED.dart';
import 'package:connectus/service/telas-ED/info-eventoED.dart';
import 'package:connectus/spalsh.dart';
import 'package:connectus/tela2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://dpjapviyzocdlpapdbzl.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRwamFwdml5em9jZGxwYXBkYnpsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY2ODExODksImV4cCI6MjA3MjI1NzE4OX0.AYPhCT2QeQrPLzuZu_QMADmLL6oI-3Y4nuLxJ6vVi4w');

  runApp(MyApp());
}

class AppAssets {
  static final Widget montanha = SvgPicture.asset(
    'images/montanhaVector.svg',
    height: 600, //double.infinity,
    width: 340, //double.infinity,
    alignment: Alignment.bottomCenter,
    fit: BoxFit.contain,
  );
  static final Widget logoConnect = SvgPicture.asset(
    'images/logobrconnectus.svg',
    height: 100, //double.infinity,
    width: 100, //double.infinity,
  );
  static final Widget logo = Image.asset(
    'images/logo.png',
    height: 100,
  );
  static final Widget montanhaB = SvgPicture.asset(
    'images/image1.svg',
    height: 470,
    width: 340,
    alignment: Alignment.bottomCenter,
    fit: BoxFit.cover,
  );
  static final Widget logoconnectusbr = SvgPicture.asset(
    'images/logobrconnectus.svg',
    height: 250,
    alignment: Alignment.bottomCenter,
    fit: BoxFit.cover,
  );
  static final Widget logobifrostbr = SvgPicture.asset(
    'images/logobifrostbr.svg',
    height: 240,
    alignment: Alignment.bottomCenter,
    fit: BoxFit.cover,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Connect Us',
      theme: ThemeData(
        fontFamily: 'Iceberg',
      ),
      home: EventED(),
    );
  }
}
