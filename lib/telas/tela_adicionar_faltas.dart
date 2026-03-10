import 'package:flutter/material.dart';
import 'package:app_vida_de_aluno/data/modelos/modelo_usuario.dart';
import 'package:app_vida_de_aluno/data/repositorios/repositorio_registro.dart';

class TelaAdicionarFaltas extends StatefulWidget {
  final ModeloUsuario aluno;
  final ModeloUsuario professor;

  const TelaAdicionarFaltas({super.key, required this.aluno, required this.professor});

  @override
  State<TelaAdicionarFaltas> createState() => _TelaAdicionarFaltasState();
}

class _TelaAdicionarFaltasState extends State<TelaAdicionarFaltas> {
  final _faltasController = TextEditingController();

  void _salvar() async {
    final faltasTxt = _faltasController.text.trim();
    if (faltasTxt.isEmpty) return;

    await RepositorioRegistro.instancia.salvarNotaOuFalta(
      alunoId: widget.aluno.id,
      disciplina: widget.professor.disciplinaProfessor!,
      faltas: int.tryParse(faltasTxt),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xFFDFFFD8),
          content: Text('Frequência atualizada!', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(title: const Text('Lançar Faltas')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFF7C8E0),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.calendar_month_rounded, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 24),
            Text('Aluno: ${widget.aluno.nome}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            TextField(
              controller: _faltasController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Número de faltas', prefixIcon: Icon(Icons.list_alt_rounded)),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: _salvar, child: const Text('SALVAR FALTAS')),
            ),
          ],
        ),
      ),
    );
  }
}