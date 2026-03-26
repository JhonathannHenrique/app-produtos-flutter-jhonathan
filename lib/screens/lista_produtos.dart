import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/produto.dart';

class ListaProdutosScreen extends StatefulWidget {
  const ListaProdutosScreen({super.key});

  @override
  State<ListaProdutosScreen> createState() => _ListaProdutosScreenState();
}

class _ListaProdutosScreenState extends State<ListaProdutosScreen> {
  final List<Produto> _produtos = [];

  void _navegarParaCadastro() async {
    final produto = await Navigator.pushNamed(context, '/cadastro');
    if (produto != null && produto is Produto) {
      setState(() {
        _produtos.add(produto);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${produto.nome} adicionado com sucesso!')),
        );
      }
    }
  }

  void _navegarParaDetalhes(Produto produto) async {
    final result = await Navigator.pushNamed(context, '/detalhes', arguments: produto);
    if (result != null && result is Map<String, dynamic>) {
      if (result['action'] == 'delete') {
        setState(() {
          _produtos.removeWhere((p) => p.id == produto.id);
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Produto removido!')),
          );
        }
      } else if (result['action'] == 'edit') {
        final editedProduto = result['produto'] as Produto;
        setState(() {
          final index = _produtos.indexWhere((p) => p.id == editedProduto.id);
          if (index != -1) {
            _produtos[index] = editedProduto;
          }
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Produto atualizado!')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatador = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.storefront),
        title: const Text('Produtos'),
      ),
      body: _produtos.isEmpty
          ? const Center(
              child: Text(
                'Nenhum produto cadastrado.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _produtos.length,
              itemBuilder: (context, index) {
                final produto = _produtos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      backgroundImage: produto.imageUrl.isNotEmpty
                          ? NetworkImage(produto.imageUrl)
                          : null,
                      child: produto.imageUrl.isEmpty ? const Icon(Icons.shopping_bag, size: 20, color: Colors.grey) : null,
                    ),
                    title: Text(produto.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(formatador.format(produto.preco)),
                    onTap: () => _navegarParaDetalhes(produto),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navegarParaCadastro,
        child: const Icon(Icons.add),
      ),
    );
  }
}
