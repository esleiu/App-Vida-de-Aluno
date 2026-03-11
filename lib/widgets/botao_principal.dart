import 'package:flutter/material.dart';

class BotaoPrincipal extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;
  final Color cor;

  const BotaoPrincipal({
    super.key,
    required this.texto,
    required this.onPressed,
    this.cor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: cor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
        ),
        child: Text(
          texto,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}