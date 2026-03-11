import 'package:flutter/material.dart';
import 'package:app_vida_de_aluno/data/modelos/modelo_usuario.dart';
import 'package:app_vida_de_aluno/telas/tela_boletim.dart';
import 'package:app_vida_de_aluno/widgets/botao_principal.dart';

class TelaAluno extends StatelessWidget {
  final ModeloUsuario usuario;

  const TelaAluno({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: const Color(0xFFF0F0F0)),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: Color(0xFFE5D1FA),
                    child: Icon(Icons.person_outline_rounded, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    usuario.nome,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ID: ${usuario.id}',
                    style: const TextStyle(color: Colors.black45, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const Spacer(),
            BotaoPrincipal(
              texto: 'BOLETIM',
              cor: const Color(0xFF2196F3),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaBoletim(aluno: usuario),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}