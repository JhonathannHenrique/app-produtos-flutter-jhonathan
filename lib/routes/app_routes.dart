
import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/detalhes/detalhes_screen.dart';
import '../screens/roteiro/roteiro_screen.dart';
import '../screens/favoritos/favoritos_screen.dart';
import '../screens/perfil/perfil_screen.dart';

class AppRoutes {
  static const home = '/';
  static const detalhes = '/detalhes';
  static const roteiro = '/roteiro';
  static const favoritos = '/favoritos';
  static const perfil = '/perfil';

  static Map<String, WidgetBuilder> routes = {
    home: (_) => const HomeScreen(),
    detalhes: (_) => const DetalhesScreen(),
    roteiro: (_) => const RoteiroScreen(),
    favoritos: (_) => const FavoritosScreen(),
    perfil: (_) => const PerfilScreen(),
  };
}
