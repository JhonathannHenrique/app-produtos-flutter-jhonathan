import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/produto.dart';

class DetalheProdutoScreen extends StatelessWidget {
  const DetalheProdutoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final produto = ModalRoute.of(context)!.settings.arguments as Produto;
    final formatador = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Produto'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, size: 22),
            onPressed: () async {
              final editedProduto = await Navigator.pushNamed(
                context,
                '/cadastro',
                arguments: produto,
              );
              if (editedProduto != null) {
                if (context.mounted) {
                  Navigator.pop(context, {'action': 'edit', 'produto': editedProduto});
                }
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, size: 22),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Excluir Produto'),
                  content: const Text('Tem certeza que deseja excluir este produto?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.pop(context, {'action': 'delete', 'id': produto.id});
                      },
                      child: const Text('Excluir', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (produto.imageUrl.isNotEmpty)
              Image.network(
                produto.imageUrl,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 250,
                    color: Colors.white,
                    child: const Icon(Icons.broken_image, size: 60, color: Colors.grey),
                  );
                },
              )
            else
              Container(
                height: 250,
                color: Colors.white,
                child: const Icon(Icons.shopping_bag, size: 60, color: Colors.grey),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.sell, size: 28, color: Colors.black87),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          produto.nome,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.attach_money, size: 24, color: Colors.green),
                      const SizedBox(width: 8),
                      Text(
                        formatador.format(produto.preco),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Icon(Icons.description, size: 20, color: Colors.grey),
                      const SizedBox(width: 8),
                      const Text(
                        'Descrição:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    produto.descricao.isNotEmpty
                        ? produto.descricao
                        : 'Nenhuma descrição fornecida.',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
