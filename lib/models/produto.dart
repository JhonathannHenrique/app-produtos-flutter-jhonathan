import 'package:uuid/uuid.dart';

class Produto {
  final String id;
  String nome;
  double preco;
  String descricao;
  String imageUrl;

  Produto({
    String? id,
    required this.nome,
    required this.preco,
    this.descricao = '',
    this.imageUrl = '',
  }) : id = id ?? const Uuid().v4();
}
