import 'package:sqflite/sqflite.dart';
import '../../core/banco_de_dados/banco_local.dart';
import '../modelos/modelo_registro_aluno.dart';

class RepositorioRegistro {
  static final RepositorioRegistro instancia = RepositorioRegistro._();
  RepositorioRegistro._();

  Future<void> salvarRegistro(ModeloRegistroAluno registro) async {
    final db = await BancoLocal.instancia.bancoDeDados;
    await db.insert(
      'registros_alunos',
      registro.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ModeloRegistroAluno>> obterRegistrosPorAluno(int alunoId) async {
    final db = await BancoLocal.instancia.bancoDeDados;
    final List<Map<String, dynamic>> maps = await db.query(
      'registros_alunos',
      where: 'aluno_id = ?',
      whereArgs: [alunoId],
    );

    return List.generate(maps.length, (i) => ModeloRegistroAluno.fromMap(maps[i]));
  }

  Future<void> salvarNotaOuFalta({
    required int alunoId,
    required String disciplina,
    int? nota,
    int? faltas,
  }) async {
    final registros = await obterRegistrosPorAluno(alunoId);
    int? idExistente;
    int notaFinal = nota ?? 0;
    int faltasFinais = faltas ?? 0;

    try {
      final registroExistente = registros.firstWhere((r) => r.disciplina == disciplina);
      idExistente = registroExistente.id;
      notaFinal = nota ?? registroExistente.nota ?? 0;
      faltasFinais = faltas ?? registroExistente.faltas ?? 0;
    } catch (_) {}

    final novo = ModeloRegistroAluno(
      id: idExistente,
      alunoId: alunoId,
      disciplina: disciplina,
      nota: notaFinal,
      faltas: faltasFinais,
    );

    await salvarRegistro(novo);
  }
}