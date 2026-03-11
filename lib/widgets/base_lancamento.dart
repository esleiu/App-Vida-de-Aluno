import 'package:flutter/material.dart';

class BaseLancamento extends StatelessWidget {
  final String tituloPagina;
  final String nomeAluno;
  final IconData icone;
  final Color corIcone;
  final String dicaCampo;
  final TextEditingController controller;
  final VoidCallback aoSalvar;
  final String textoBotao;

  const BaseLancamento({
    super.key,
    required this.tituloPagina,
    required this.nomeAluno,
    required this.icone,
    required this.corIcone,
    required this.dicaCampo,
    required this.controller,
    required this.aoSalvar,
    required this.textoBotao,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(title: Text(tituloPagina)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: corIcone,
                shape: BoxShape.circle,
              ),
              child: Icon(icone, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 24),
            Text('Aluno: $nomeAluno', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: dicaCampo,
                prefixIcon: Icon(icone, size: 20),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: aoSalvar, child: Text(textoBotao)),
            ),
          ],
        ),
      ),
    );
  }
}