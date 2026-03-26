import 'package:flutter/material.dart';
import '../models/produto.dart';

class CadastroProdutoScreen extends StatefulWidget {
  const CadastroProdutoScreen({super.key});

  @override
  State<CadastroProdutoScreen> createState() => _CadastroProdutoScreenState();
}

class _CadastroProdutoScreenState extends State<CadastroProdutoScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _precoController;
  late TextEditingController _descricaoController;
  late TextEditingController _imageUrlController;
  Produto? _produtoParaEditar;
  bool _isEditing = false;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null && arg is Produto) {
        _produtoParaEditar = arg;
        _isEditing = true;
      }
      
      _nomeController = TextEditingController(text: _produtoParaEditar?.nome ?? '');
      _precoController = TextEditingController(text: _produtoParaEditar?.preco.toString() ?? '');
      _descricaoController = TextEditingController(text: _produtoParaEditar?.descricao ?? '');
      _imageUrlController = TextEditingController(text: _produtoParaEditar?.imageUrl ?? '');
      
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    _descricaoController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final preco = double.tryParse(_precoController.text.replaceAll(',', '.')) ?? 0.0;
      
      if (_isEditing && _produtoParaEditar != null) {
        _produtoParaEditar!.nome = _nomeController.text;
        _produtoParaEditar!.preco = preco;
        _produtoParaEditar!.descricao = _descricaoController.text;
        _produtoParaEditar!.imageUrl = _imageUrlController.text;
        Navigator.pop(context, _produtoParaEditar);
      } else {
        final novoProduto = Produto(
          nome: _nomeController.text,
          preco: preco,
          descricao: _descricaoController.text,
          imageUrl: _imageUrlController.text,
        );
        Navigator.pop(context, novoProduto);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Produto' : 'Novo Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do Produto',
                  prefixIcon: Icon(Icons.sell),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o nome do produto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _precoController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Preço',
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(),
                  prefixText: 'R\$ ',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o preço do produto';
                  }
                  if (double.tryParse(value.replaceAll(',', '.')) == null) {
                    return 'Preço inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descricaoController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descrição (Opcional)',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'URL da Imagem (Opcional)',
                  prefixIcon: Icon(Icons.image),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _salvar,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                icon: const Icon(Icons.save),
                label: const Text('Salvar', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
