import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_vida_de_aluno/data/modelos/modelo_usuario.dart';
import 'package:app_vida_de_aluno/provedores/provedor_usuario.dart';
import 'package:app_vida_de_aluno/data/repositorios/repositorio_usuario.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _nomeController = TextEditingController();
  final _usernameController = TextEditingController();
  bool _ehProfessor = false;
  String? _disciplina;

  void _cadastrar() async {
    if (_nomeController.text.isEmpty || _usernameController.text.isEmpty) return;

    final novoUsuario = ModeloUsuario(
      id: DateTime.now().millisecondsSinceEpoch,
      nome: _nomeController.text,
      username: _usernameController.text,
      isProfessor: _ehProfessor,
      disciplinaProfessor: _ehProfessor ? _disciplina : null,
    );

    await RepositorioUsuario().inserirUsuario(novoUsuario);
    if (mounted) {
      context.read<ProvedorUsuario>().carregarUsuarios();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _nomeController, decoration: const InputDecoration(labelText: 'Nome Completo')),
            TextField(controller: _usernameController, decoration: const InputDecoration(labelText: 'Username')),
            SwitchListTile(
              title: const Text('É Professor?'),
              value: _ehProfessor,
              onChanged: (val) => setState(() => _ehProfessor = val),
            ),
            if (_ehProfessor)
              TextField(
                onChanged: (val) => _disciplina = val,
                decoration: const InputDecoration(labelText: 'Disciplina'),
              ),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: _cadastrar, child: const Text('SALVAR CADASTRO')),
          ],
        ),
      ),
    );
  }
}