import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_vida_de_aluno/data/modelos/modelo_usuario.dart';
import 'package:app_vida_de_aluno/data/modelos/modelo_registro_aluno.dart';
import 'package:app_vida_de_aluno/data/repositorios/repositorio_registro.dart';
import 'package:app_vida_de_aluno/provedores/provedor_usuario.dart';
import 'package:app_vida_de_aluno/telas/tela_detalhe_disciplina.dart';
import 'package:app_vida_de_aluno/widgets/card_informativo.dart';

class TelaBoletim extends StatefulWidget {
  final ModeloUsuario aluno;

  const TelaBoletim({super.key, required this.aluno});

  @override
  State<TelaBoletim> createState() => _TelaBoletimState();
}

class _TelaBoletimState extends State<TelaBoletim> {
  final List<String> _disciplinas = ['Algoritmos', 'Redes', 'Banco de Dados'];
  List<ModeloRegistroAluno> _registros = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() async {
    final registros = await RepositorioRegistro.instancia.obterRegistrosPorAluno(widget.aluno.id);
    if (mounted) {
      setState(() {
        _registros = registros;
        _carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final todosUsuarios = context.watch<ProvedorUsuario>().usuarios;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(title: const Text('Boletim')),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: _disciplinas.length,
              itemBuilder: (context, index) {
                final disciplina = _disciplinas[index];
                
                String nomeProfessor = "Não atribuído";
                try {
                  final professor = todosUsuarios.firstWhere(
                    (u) => u.isProfessor && u.disciplinaProfessor == disciplina
                  );
                  nomeProfessor = professor.nome;
                } catch (_) {}

                final registro = _registros.cast<ModeloRegistroAluno?>().firstWhere(
                  (r) => r?.disciplina == disciplina, 
                  orElse: () => null
                );

                bool jaLancado = registro != null;

                return CardInformativo(
                  titulo: disciplina,
                  subtitulo: 'Prof: $nomeProfessor',
                  icone: Icons.book_rounded,
                  destaque: jaLancado,
                  rotuloStatus: 'Aguardando lançamento...',
                  onTap: jaLancado ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaDetalheDisciplina(
                          disciplina: disciplina,
                          professor: nomeProfessor,
                          registro: registro!,
                        ),
                      ),
                    );
                  } : null,
                  acao: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: jaLancado ? const Color(0xFFB4E4FF).withOpacity(0.4) : Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      jaLancado ? 'DETALHAR' : 'PENDENTE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: jaLancado ? const Color(0xFF6DA9E4) : Colors.orange,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}