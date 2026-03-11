import 'package:sqflite/sqflite.dart';
import 'package:app_vida_de_aluno/core/banco_de_dados/banco_local.dart';
import 'package:app_vida_de_aluno/data/modelos/modelo_usuario.dart';
import 'package:app_vida_de_aluno/data/servicos/servico_api.dart';

class RepositorioUsuario {
  final ServicoApi _api = ServicoApi();

  Future<void> sincronizarUsuarios() async {
    final db = await BancoLocal.instancia.bancoDeDados;
    
    final usuariosExistentes = await obterUsuarios();
    if (usuariosExistentes.isNotEmpty) return;

    try {
      final usuariosApi = await _api.buscarUsuarios();
      Batch batch = db.batch();
      for (var usuario in usuariosApi) {
        batch.insert(
          'usuarios',
          usuario.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    } catch (e) {
      rethrow; 
    }
  }

  Future<List<ModeloUsuario>> obterUsuarios() async {
    final db = await BancoLocal.instancia.bancoDeDados;
    final List<Map<String, dynamic>> maps = await db.query('usuarios');
    return List.generate(maps.length, (i) => ModeloUsuario.fromMap(maps[i]));
  }
}