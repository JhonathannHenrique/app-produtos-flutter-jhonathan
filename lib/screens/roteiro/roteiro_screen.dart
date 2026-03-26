
import 'package:flutter/material.dart';

class RoteiroScreen extends StatelessWidget {
  const RoteiroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Roteiro')),
      body: ListView(
        children: const [
          ListTile(title: Text('Ponto Turístico 1')),
          ListTile(title: Text('Ponto Turístico 2')),
        ],
      ),
    );
  }
}
