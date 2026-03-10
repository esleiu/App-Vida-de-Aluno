import 'package:flutter/material.dart';
import 'package:app_vida_de_aluno/data/modelos/modelo_usuario.dart';
import 'package:app_vida_de_aluno/data/modelos/modelo_registro_aluno.dart';
import 'package:app_vida_de_aluno/data/repositorios/repositorio_registro.dart';
import 'package:app_vida_de_aluno/telas/tela_adicionar_nota.dart';
import 'package:app_vida_de_aluno/telas/tela_adicionar_faltas.dart';

class TelaDetalheAlunoProfessor extends StatefulWidget {
  final ModeloUsuario aluno;
  final ModeloUsuario professor;

  const TelaDetalheAlunoProfessor({
    super.key,
    required this.aluno,
    required this.professor,
  });

  @override
  State<TelaDetalheAlunoProfessor> createState() => _TelaDetalheAlunoProfessorState();
}

class _TelaDetalheAlunoProfessorState extends State<TelaDetalheAlunoProfessor> {
  final _repo = RepositorioRegistro.instancia;
  ModeloRegistroAluno? _registroAtual;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() async {
    final registros = await _repo.obterRegistrosPorAluno(widget.aluno.id);
    try {
      final encontrado = registros.firstWhere(
        (r) => r.disciplina == widget.professor.disciplinaProfessor,
      );
      setState(() => _registroAtual = encontrado);
    } catch (_) {
      setState(() => _registroAtual = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(title: const Text('Detalhamento')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
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
                    radius: 40,
                    backgroundColor: Color(0xFFE5D1FA),
                    child: Icon(Icons.person_rounded, color: Colors.white, size: 45),
                  ),
                  const SizedBox(height: 16),
                  Text(widget.aluno.nome, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                  Text('Matrícula: ${widget.aluno.id}', style: const TextStyle(color: Colors.black38)),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoStatus('Nota', _registroAtual?.nota?.toString() ?? '-'),
                      _buildInfoStatus('Faltas', _registroAtual?.faltas?.toString() ?? '-'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildAcaoCard(
              context,
              titulo: 'Lançar Nota',
              subtitulo: 'Atualizar desempenho',
              icone: Icons.grade_rounded,
              cor: const Color(0xFF6DA9E4),
              destino: TelaAdicionarNota(aluno: widget.aluno, professor: widget.professor),
            ),
            const SizedBox(height: 16),
            _buildAcaoCard(
              context,
              titulo: 'Lançar Frequência',
              subtitulo: 'Atualizar faltas',
              icone: Icons.calendar_month_rounded,
              cor: const Color(0xFFF7C8E0),
              destino: TelaAdicionarFaltas(aluno: widget.aluno, professor: widget.professor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoStatus(String label, String valor) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black38, fontWeight: FontWeight.bold)),
        Text(valor, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF6DA9E4))),
      ],
    );
  }

  Widget _buildAcaoCard(BuildContext context, {required String titulo, required String subtitulo, required IconData icone, required Color cor, required Widget destino}) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => destino));
          _carregarDados();
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFF0F0F0)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icone, color: cor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(subtitulo, style: const TextStyle(fontSize: 12, color: Colors.black38)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Colors.black26),
            ],
          ),
        ),
      ),
    );
  }
}