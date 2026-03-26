
import 'package:flutter/material.dart';
import '../../models/viagem.dart';
import '../../routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  final viagens = [
    Viagem('Paris', 'Cidade luz'),
    Viagem('Roma', 'História e cultura'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Viagens')),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Menu')),
            ListTile(
              title: const Text('Perfil'),
              onTap: () => Navigator.pushNamed(context, AppRoutes.perfil),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: viagens.length,
        itemBuilder: (_, i) => ListTile(
          title: Text(viagens[i].destino),
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutes.detalhes,
            arguments: viagens[i],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          setState(() => index = i);
          if (i == 1) Navigator.pushNamed(context, AppRoutes.favoritos);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos'),
        ],
      ),
    );
  }
}
