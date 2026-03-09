import 'package:flutter/material.dart';
import 'package:app_vida_de_aluno/data/modelos/modelo_usuario.dart';
import 'package:app_vida_de_aluno/data/repositorios/repositorio_usuario.dart';

class ProvedorUsuario with ChangeNotifier {
  final RepositorioUsuario _repositorio = RepositorioUsuario();
  List<ModeloUsuario> _usuarios = [];
  bool _carregando = false;

  List<ModeloUsuario> get usuarios => _usuarios;
  bool get carregando => _carregando;

  Future<void> carregarUsuarios() async {
    _carregando = true;
    notifyListeners();

    await _repositorio.sincronizarUsuarios();
    _usuarios = await _repositorio.obterUsuarios();

    _carregando = false;
    notifyListeners();
  }
}