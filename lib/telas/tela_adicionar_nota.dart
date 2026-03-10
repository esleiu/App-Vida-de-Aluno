import 'package:flutter/material.dart';
import 'package:app_vida_de_aluno/data/modelos/modelo_usuario.dart';
import 'package:app_vida_de_aluno/data/repositorios/repositorio_registro.dart';

class TelaAdicionarNota extends StatefulWidget {
  final ModeloUsuario aluno;
  final ModeloUsuario professor;

  const TelaAdicionarNota({super.key, required this.aluno, required this.professor});

  @override
  State<TelaAdicionarNota> createState() => _TelaAdicionarNotaState();
}

class _TelaAdicionarNotaState extends State<TelaAdicionarNota> {
  final _notaController = TextEditingController();

  void _salvar() async {
    final notaTxt = _notaController.text.trim();
    if (notaTxt.isEmpty) return;

    await RepositorioRegistro.instancia.salvarNotaOuFalta(
      alunoId: widget.aluno.id,
      disciplina: widget.professor.disciplinaProfessor!,
      nota: int.tryParse(notaTxt),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xFFDFFFD8),
          content: Text('Nota atualizada com sucesso!', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(title: const Text('Lançar Nota')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF6DA9E4),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.grade_rounded, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 24),
            Text('Aluno: ${widget.aluno.nome}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            TextField(
              controller: _notaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Nota (0-100)', prefixIcon: Icon(Icons.edit_note_rounded)),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: _salvar, child: const Text('SALVAR NOTA')),
            ),
          ],
        ),
      ),
    );
  }
}