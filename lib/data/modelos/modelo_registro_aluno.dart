class ModeloRegistroAluno {
  final int? id;
  final int alunoId;
  final String disciplina;
  final double? nota;
  final int? faltas;

  ModeloRegistroAluno({
    this.id,
    required this.alunoId,
    required this.disciplina,
    this.nota,
    this.faltas,
  });

  factory ModeloRegistroAluno.fromMap(Map<String, dynamic> map) {
    return ModeloRegistroAluno(
      id: map['id'],
      alunoId: map['aluno_id'],
      disciplina: map['disciplina'],
      nota: map['nota'],
      faltas: map['faltas'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'aluno_id': alunoId,
      'disciplina': disciplina,
      'nota': nota,
      'faltas': faltas,
    };
  }
}