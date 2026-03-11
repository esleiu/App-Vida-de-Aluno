import 'package:flutter/material.dart';
import 'package:app_vida_de_aluno/data/modelos/modelo_registro_aluno.dart';

class TelaDetalheDisciplina extends StatelessWidget {
  final String disciplina;
  final String professor;
  final ModeloRegistroAluno registro;

  const TelaDetalheDisciplina({
    super.key,
    required this.disciplina,
    required this.professor,
    required this.registro,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(title: const Text('Detalhes da Disciplina')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              disciplina,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF2196F3)),
            ),
            Text(
              'Professor(a): $professor',
              style: const TextStyle(fontSize: 16, color: Colors.black45, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: const Color(0xFFF0F0F0)),
              ),
              child: Column(
                children: [
                  _buildItemDetalhe('NOTA FINAL', '${registro.nota ?? 0}', const Color(0xFF6DA9E4)),
                  const SizedBox(height: 32),
                  const Divider(color: Color(0xFFF0F0F0)),
                  const SizedBox(height: 32),
                  _buildItemDetalhe('TOTAL DE FALTAS', '${registro.faltas ?? 0}', const Color(0xFFF7C8E0)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemDetalhe(String titulo, String valor, Color cor) {
    return Column(
      children: [
        Text(titulo, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black38)),
        const SizedBox(height: 8),
        Text(valor, style: TextStyle(fontSize: 54, fontWeight: FontWeight.w900, color: cor)),
      ],
    );
  }
}