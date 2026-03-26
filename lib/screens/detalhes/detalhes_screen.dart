
import 'package:flutter/material.dart';
import '../../models/viagem.dart';
import '../../routes/app_routes.dart';

class DetalhesScreen extends StatelessWidget {
  const DetalhesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viagem = ModalRoute.of(context)!.settings.arguments as Viagem;

    return Scaffold(
      appBar: AppBar(title: Text(viagem.destino)),
      body: Column(
        children: [
          Text(viagem.descricao),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.roteiro),
            child: const Text('Ver Roteiro'),
          ),
        ],
      ),
    );
  }
}
