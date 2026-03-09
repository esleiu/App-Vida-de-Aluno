import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modelos/modelo_usuario.dart';

class ServicoApi {
  static const String _urlBase = 'https://jsonplaceholder.typicode.com/users';

  Future<List<ModeloUsuario>> buscarUsuarios() async {
    final resposta = await http.get(Uri.parse(_urlBase));

    if (resposta.statusCode == 200) {
      final List<dynamic> dadosJson = json.decode(resposta.body);
      List<ModeloUsuario> usuarios = [];

      for (int i = 0; i < dadosJson.length; i++) {
        var json = dadosJson[i];
        bool isProfessor = i < 3;
        String? disciplina;

        if (i == 0) {
          disciplina = 'Algoritmos';
        } else if (i == 1) {
          disciplina = 'Redes';
        } else if (i == 2) {
          disciplina = 'Banco de Dados';
        }

        usuarios.add(ModeloUsuario.fromJson(json, isProfessor, disciplina));
      }
      return usuarios;
    } else {
      throw Exception('Falha ao carregar usuários');
    }
  }
}