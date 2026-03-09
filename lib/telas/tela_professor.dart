import 'package:flutter/material.dart';
import 'package:app_vida_de_aluno/data/modelos/modelo_usuario.dart';

class TelaProfessor extends StatelessWidget {
  final ModeloUsuario usuario;

  const TelaProfessor({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Portal do Professor'),
      ),
      body: Center(
        child: Text('Bem-vindo, Professor(a) de ${usuario.disciplinaProfessor}!'),
      ),
    );
  }
}