import 'package:flutter/material.dart';
import 'package:app_vida_de_aluno/data/modelos/modelo_usuario.dart';
import 'package:app_vida_de_aluno/data/repositorios/repositorio_registro.dart';
import 'package:app_vida_de_aluno/widgets/base_lancamento.dart';

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
          content: Text('Frequência atualizada!', style: TextStyle(color: Colors.black87)),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLancamento(
      tituloPagina: 'Lançar Faltas',
      nomeAluno: widget.aluno.nome,
      icone: Icons.calendar_month_rounded,
      corIcone: const Color(0xFFF7C8E0),
      dicaCampo: 'Número de faltas',
      controller: _faltasController,
      aoSalvar: _salvar,
      textoBotao: 'SALVAR FALTAS',
    );
  }
}