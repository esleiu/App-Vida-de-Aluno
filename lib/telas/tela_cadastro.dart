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
  final _senhaController = TextEditingController();
  bool _ehProfessor = false;
  String? _disciplinaSelecionada;

  final List<String> _disciplinasDisponiveis = [
    'Algoritmos',
    'Redes',
    'Banco de Dados'
  ];

  void _cadastrar() async {
    if (_nomeController.text.isEmpty || 
        _usernameController.text.isEmpty || 
        _senhaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos')),
      );
      return;
    }

    final novoUsuario = ModeloUsuario(
      id: DateTime.now().millisecondsSinceEpoch,
      nome: _nomeController.text,
      username: _usernameController.text,
      senha: _senhaController.text,
      isProfessor: _ehProfessor,
      disciplinaProfessor: _ehProfessor ? _disciplinaSelecionada : null,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome Completo'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _senhaController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('É Professor?'),
              value: _ehProfessor,
              onChanged: (val) {
                setState(() {
                  _ehProfessor = val;
                });
              },
            ),
            if (_ehProfessor)
              DropdownButtonFormField<String>(
                value: _disciplinaSelecionada,
                decoration: const InputDecoration(labelText: 'Disciplina'),
                items: _disciplinasDisponiveis.map((String d) {
                  return DropdownMenuItem(value: d, child: Text(d));
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _disciplinaSelecionada = val;
                  });
                },
              ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _cadastrar,
                child: const Text('SALVAR CADASTRO'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}