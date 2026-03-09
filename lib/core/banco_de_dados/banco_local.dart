import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BancoLocal {
  static final BancoLocal instancia = BancoLocal._iniciar();
  static Database? _bancoDeDados;

  BancoLocal._iniciar();

  Future<Database> get bancoDeDados async {
    if (_bancoDeDados != null) return _bancoDeDados!;
    _bancoDeDados = await _iniciarBanco();
    return _bancoDeDados!;
  }

  Future<Database> _iniciarBanco() async {
    final caminhoBanco = await getDatabasesPath();
    final caminho = join(caminhoBanco, 'vida_de_aluno.db');

    return await openDatabase(
      caminho,
      version: 1,
      onCreate: _criarBanco,
    );
  }

  Future<void> _criarBanco(Database db, int versao) async {
    await db.execute('''
      CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY,
        nome TEXT,
        username TEXT,
        email TEXT,
        telefone TEXT,
        is_professor INTEGER,
        disciplina_professor TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE registros_alunos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        aluno_id INTEGER,
        disciplina TEXT,
        nota REAL,
        faltas INTEGER,
        FOREIGN KEY (aluno_id) REFERENCES usuarios (id) ON DELETE CASCADE
      )
    ''');
  }
}