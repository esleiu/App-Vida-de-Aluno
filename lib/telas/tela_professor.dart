import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_vida_de_aluno/data/modelos/modelo_usuario.dart';
import 'package:app_vida_de_aluno/provedores/provedor_usuario.dart';
import 'package:app_vida_de_aluno/telas/tela_detalhe_aluno_professor.dart';
import 'package:app_vida_de_aluno/data/repositorios/repositorio_registro.dart';
import 'package:app_vida_de_aluno/data/modelos/modelo_registro_aluno.dart';

class TelaProfessor extends StatefulWidget {
  final ModeloUsuario usuario;

  const TelaProfessor({super.key, required this.usuario});

  @override
  State<TelaProfessor> createState() => _TelaProfessorState();
}

class _TelaProfessorState extends State<TelaProfessor> {
  String _filtro = '';
  final _repoRegistro = RepositorioRegistro.instancia;

  @override
  Widget build(BuildContext context) {
    final todosAlunos = context.watch<ProvedorUsuario>().usuarios.where((u) => !u.isProfessor).toList();
    final alunosFiltrados = todosAlunos.where((aluno) {
      return aluno.nome.toLowerCase().contains(_filtro.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220.0,
            pinned: true,
            backgroundColor: const Color(0xFFDFFFD8),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Olá, Prof. ${widget.usuario.nome}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.usuario.disciplinaProfessor ?? '',
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: TextField(
                  onChanged: (value) => setState(() => _filtro = value),
                  decoration: InputDecoration(
                    hintText: 'Pesquisar aluno...',
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF6DA9E4)),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final aluno = alunosFiltrados[index];
                  
                  return FutureBuilder<List<ModeloRegistroAluno>>(
                    future: _repoRegistro.obterRegistrosPorAluno(aluno.id),
                    builder: (context, snapshot) {
                      bool jaLancado = false;
                      if (snapshot.hasData) {
                        jaLancado = snapshot.data!.any((r) => r.disciplina == widget.usuario.disciplinaProfessor);
                      }

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: jaLancado ? const Color(0xFFDFFFD8) : const Color(0xFFF0F0F0),
                            width: jaLancado ? 2 : 1,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TelaDetalheAlunoProfessor(
                                  aluno: aluno,
                                  professor: widget.usuario,
                                ),
                              ),
                            );
                            setState(() {});
                          },
                          leading: Stack(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE5D1FA),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.person_rounded, color: Colors.white, size: 30),
                              ),
                              if (jaLancado)
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                                    child: const Icon(Icons.check, color: Colors.white, size: 10),
                                  ),
                                ),
                            ],
                          ),
                          title: Text(
                            aluno.nome,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Text(
                            'Matrícula: ${aluno.id}',
                            style: const TextStyle(fontSize: 12, color: Colors.black38),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: jaLancado ? Colors.green.withOpacity(0.1) : const Color(0xFFB4E4FF).withOpacity(0.4),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              jaLancado ? 'EDITAR' : 'LANÇAR',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: jaLancado ? Colors.green : const Color(0xFF6DA9E4),
                              ),
                            ),
                          ),
                        ),
                      );
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