class ModeloUsuario {
  final int id;
  final String nome;
  final String username;
  final String? email;
  final String? telefone;
  final bool isProfessor;
  final String? disciplinaProfessor;

  ModeloUsuario({
    required this.id,
    required this.nome,
    required this.username,
    this.email,
    this.telefone,
    required this.isProfessor,
    this.disciplinaProfessor,
  });

  factory ModeloUsuario.fromJson(Map<String, dynamic> json, bool isProfessor, String? disciplinaProfessor) {
    return ModeloUsuario(
      id: json['id'],
      nome: json['name'],
      username: json['username'],
      email: json['email'],
      telefone: json['phone'],
      isProfessor: isProfessor,
      disciplinaProfessor: disciplinaProfessor,
    );
  }

  factory ModeloUsuario.fromMap(Map<String, dynamic> map) {
    return ModeloUsuario(
      id: map['id'],
      nome: map['nome'],
      username: map['username'],
      email: map['email'],
      telefone: map['telefone'],
      isProfessor: map['is_professor'] == 1,
      disciplinaProfessor: map['disciplina_professor'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'username': username,
      'email': email,
      'telefone': telefone,
      'is_professor': isProfessor ? 1 : 0,
      'disciplina_professor': disciplinaProfessor,
    };
  }
}