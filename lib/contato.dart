class Contato {
  int? id;
  String nome;
  String contato;

  Contato({this.id, required this.nome, required this.contato});

  factory Contato.fromJson(Map<String, dynamic> json) => Contato(
    id: json['id'],
    nome: json['nome'],
    contato: json['contato'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'contato': contato,
  };
}
