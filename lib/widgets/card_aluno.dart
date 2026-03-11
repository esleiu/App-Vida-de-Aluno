import 'package:flutter/material.dart';
import 'package:app_vida_de_aluno/data/modelos/modelo_usuario.dart';

class CardAluno extends StatelessWidget {
  final ModeloUsuario aluno;
  final bool jaLancado;
  final String disciplinaProfessor;
  final VoidCallback onTap;

  const CardAluno({
    super.key,
    required this.aluno,
    required this.jaLancado,
    required this.disciplinaProfessor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const double alturaCard = 90.0;
    const double tamanhoIcone = 48.0;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: jaLancado ? const Color(0xFFC8E6C9) : const Color(0xFFEEEEEE),
          width: jaLancado ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: alturaCard,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    height: tamanhoIcone,
                    width: tamanhoIcone,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE5D1FA),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person_rounded, color: Colors.white, size: 28),
                  ),
                  if (jaLancado)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                        child: const Icon(Icons.check, color: Colors.white, size: 12),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      aluno.nome,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Matrícula: ${aluno.id}',
                      style: const TextStyle(fontSize: 12, color: Colors.black45),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2196F3).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        disciplinaProfessor.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 9, 
                          fontWeight: FontWeight.bold, 
                          color: Color(0xFF2196F3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: jaLancado ? Colors.green.withOpacity(0.1) : const Color(0xFFB4E4FF).withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  jaLancado ? 'EDITAR' : 'LANÇAR',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: jaLancado ? Colors.green : const Color(0xFF6DA9E4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}