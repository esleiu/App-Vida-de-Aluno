import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_vida_de_aluno/provedores/provedor_usuario.dart';
import 'package:app_vida_de_aluno/telas/tela_aluno.dart';
import 'package:app_vida_de_aluno/telas/tela_professor.dart';
import 'package:app_vida_de_aluno/widgets/campo_texto_customizado.dart';
import 'package:app_vida_de_aluno/widgets/botao_principal.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController _controleNome = TextEditingController();
  final TextEditingController _controleSenha = TextEditingController();

  void _tentarLogin() {
    final provedor = context.read<ProvedorUsuario>();
    final nome = _controleNome.text.trim();
    final senha = _controleSenha.text.trim();

    if (nome.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(backgroundColor: Colors.redAccent, content: Text('Preencha os campos')),
      );
      return;
    }

    try {
      final usuario = provedor.usuarios.firstWhere(
        (u) => u.nome.toLowerCase() == nome.toLowerCase() && u.senha == senha,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => usuario.isProfessor 
            ? TelaProfessor(usuario: usuario) 
            : TelaAluno(usuario: usuario)
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(backgroundColor: Colors.redAccent, content: Text('Acesso negado!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2196F3),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.school_rounded, size: 100, color: Colors.white),
              const SizedBox(height: 16),
              const Text(
                'Vida de Aluno',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.white),
              ),
              const SizedBox(height: 40),
              CampoTextoCustomizado(
                controller: _controleNome,
                hintText: 'Nome Completo',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
              CampoTextoCustomizado(
                controller: _controleSenha,
                hintText: 'Senha (ID)',
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: 32),
              BotaoPrincipal(
                texto: 'ENTRAR',
                onPressed: _tentarLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}