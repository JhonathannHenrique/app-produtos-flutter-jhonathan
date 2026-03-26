import 'package:flutter/material.dart';
import 'screens/lista_produtos.dart';
import 'screens/cadastro_produto.dart';
import 'screens/detalhe_produto.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEBEBEB),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFE600),
          primary: const Color(0xFF3483FA), 
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFE600),
          foregroundColor: Color(0xFF333333),
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3483FA),
            foregroundColor: Colors.white,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF3483FA),
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ListaProdutosScreen(),
        '/cadastro': (context) => const CadastroProdutoScreen(),
        '/detalhes': (context) => const DetalheProdutoScreen(),
      },
    );
  }
}
