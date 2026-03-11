import 'package:flutter/material.dart';

class CardInformativo extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final String? rotuloStatus;
  final IconData icone;
  final Color corIcone;
  final VoidCallback? onTap;
  final Widget? acao;
  final bool destaque;

  const CardInformativo({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.icone,
    this.rotuloStatus,
    this.corIcone = const Color(0xFFE5D1FA),
    this.onTap,
    this.acao,
    this.destaque = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: destaque ? const Color(0xFFC8E6C9) : const Color(0xFFEEEEEE),
          width: destaque ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 90.0,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: corIcone,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icone, color: Colors.white, size: 28),
                  ),
                  if (destaque)
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
                    Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(subtitulo, style: const TextStyle(fontSize: 12, color: Colors.black45)),
                    if (rotuloStatus != null && !destaque)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          rotuloStatus!,
                          style: const TextStyle(fontSize: 9, color: Colors.orange, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
              ),
              if (acao != null) acao!,
            ],
          ),
        ),
      ),
    );
  }
}