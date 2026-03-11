import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_vida_de_aluno/data/modelos/modelo_usuario.dart';
import 'package:app_vida_de_aluno/provedores/provedor_usuario.dart';
import 'package:app_vida_de_aluno/telas/tela_detalhe_aluno_professor.dart';
import 'package:app_vida_de_aluno/data/repositorios/repositorio_registro.dart';
import 'package:app_vida_de_aluno/data/modelos/modelo_registro_aluno.dart';
import 'package:app_vida_de_aluno/widgets/card_aluno.dart';
import 'package:app_vida_de_aluno/widgets/campo_texto_customizado.dart';

class TelaProfessor extends StatefulWidget {
  final ModeloUsuario usuario;
  const TelaProfessor({super.key, required this.usuario});

  @override
  State<TelaProfessor> createState() => _TelaProfessorState();
}

class _TelaProfessorState extends State<TelaProfessor> {
  final _controleBusca = TextEditingController();
  String _filtro = '';
  List<ModeloRegistroAluno> _todosRegistros = [];

  @override
  void initState() {
    super.initState();
    _carregarDadosIniciais();
  }

  Future<void> _carregarDadosIniciais() async {
    final registros = await RepositorioRegistro.instancia.obterTodosRegistros();
    setState(() {
      _todosRegistros = registros;
    });
  }

  @override
  Widget build(BuildContext context) {
    final todosAlunos = context.watch<ProvedorUsuario>().usuarios.where((u) => !u.isProfessor).toList();
    final alunosFiltrados = todosAlunos.where((aluno) => aluno.nome.toLowerCase().contains(_filtro.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180.0,
            pinned: true,
            centerTitle: true,
            backgroundColor: const Color(0xFF2196F3),
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.only(bottom: 16),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Prof. ${widget.usuario.nome}', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(widget.usuario.disciplinaProfessor?.toUpperCase() ?? '', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 11, letterSpacing: 1.2)),
                ],
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF1976D2), Color(0xFF2196F3)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
              child: CampoTextoCustomizado(
                controller: _controleBusca,
                hintText: 'Pesquisar aluno...',
                icon: Icons.search,
                onChanged: (val) => setState(() => _filtro = val),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final aluno = alunosFiltrados[index];
                  bool jaLancado = _todosRegistros.any((r) => r.alunoId == aluno.id && r.disciplina == widget.usuario.disciplinaProfessor);
                  
                  return CardAluno(
                    aluno: aluno,
                    jaLancado: jaLancado,
                    disciplinaProfessor: widget.usuario.disciplinaProfessor ?? '',
                    onTap: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (context) => TelaDetalheAlunoProfessor(aluno: aluno, professor: widget.usuario)));
                      _carregarDadosIniciais();
                    },
                  );
                },
                childCount: alunosFiltrados.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}