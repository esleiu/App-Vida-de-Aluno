import 'package:flutter/material.dart';
import 'package:app_vida_de_aluno/data/modelos/modelo_usuario.dart';

class TelaAluno extends StatelessWidget {
  final ModeloUsuario usuario;

  const TelaAluno({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Portal do Aluno'),
      ),
      body: Center(
        child: Text('Bem-vindo, Aluno(a) ${usuario.nome}!'),
      ),
    );
  }
}