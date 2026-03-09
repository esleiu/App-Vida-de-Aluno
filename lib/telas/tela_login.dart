import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_vida_de_aluno/provedores/provedor_usuario.dart';
import 'package:app_vida_de_aluno/telas/tela_aluno.dart';
import 'package:app_vida_de_aluno/telas/tela_professor.dart';
import 'package:app_vida_de_aluno/telas/tela_cadastro.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController _controleUsuario = TextEditingController();

  void _tentarLogin() {
    final provedor = context.read<ProvedorUsuario>();
    final usernameDigitado = _controleUsuario.text.trim();

    if (usernameDigitado.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xFFF7C8E0),
          content: Text('Por favor, digite seu usuário', style: TextStyle(color: Colors.black87)),
        ),
      );
      return;
    }

    try {
      final usuario = provedor.usuarios.firstWhere(
        (u) => u.username.toLowerCase() == usernameDigitado.toLowerCase(),
      );

      if (usuario.isProfessor) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TelaProfessor(usuario: usuario)),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TelaAluno(usuario: usuario)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xFFF7C8E0),
          content: Text('Usuário não encontrado!', style: TextStyle(color: Colors.black87)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5D1FA),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.auto_stories_rounded, size: 80, color: Color(0xFF6DA9E4)),
              ),
              const SizedBox(height: 24),
              const Text(
                'Vida de Aluno',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _controleUsuario,
                decoration: const InputDecoration(
                  hintText: 'Digite seu usuário',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _tentarLogin,
                  child: const Text(
                    'ENTRAR',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TelaCadastro()),
                  );
                },
                child: const Text(
                  'Criar conta agora',
                  style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}