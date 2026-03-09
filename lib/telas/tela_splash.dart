import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_vida_de_aluno/provedores/provedor_usuario.dart';
import 'package:app_vida_de_aluno/telas/tela_login.dart';

class TelaSplash extends StatefulWidget {
  const TelaSplash({super.key});

  @override
  State<TelaSplash> createState() => _TelaSplashState();
}

class _TelaSplashState extends State<TelaSplash> {
  @override
  void initState() {
    super.initState();
    _sincronizar();
  }

  void _sincronizar() async {
    await context.read<ProvedorUsuario>().carregarUsuarios();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TelaLogin()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF8F9FD),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_stories_rounded, size: 100, color: Color(0xFF6DA9E4)),
            SizedBox(height: 40),
            CircularProgressIndicator(
              color: Color(0xFFB4E4FF),
              strokeWidth: 6,
            ),
          ],
        ),
      ),
    );
  }
}