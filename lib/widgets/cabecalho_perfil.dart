import 'package:flutter/material.dart';
import 'package:app_vida_de_aluno/data/modelos/modelo_usuario.dart';

class CabecalhoPerfil extends StatelessWidget {
  final ModeloUsuario usuario;
  final List<Widget>? estatisticas;

  const CabecalhoPerfil({super.key, required this.usuario, this.estatisticas});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            radius: 45,
            backgroundColor: Color(0xFFE5D1FA),
            child: Icon(Icons.person_outline_rounded, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            usuario.nome,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'Matrícula: ${usuario.id}',
            style: const TextStyle(color: Colors.black45, fontWeight: FontWeight.w500),
          ),
          if (estatisticas != null) ...[
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: estatisticas!,
            ),
          ],
        ],
      ),
    );
  }
}