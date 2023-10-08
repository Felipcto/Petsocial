import 'package:flutter/material.dart';
import 'cadastro.dart'; // Importando o arquivo da tela de cadastro

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TelaInicial(),
    );
  }
}

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset('assets/image/petsocial.png', fit: BoxFit.cover),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/ilusta.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0), // Espaçamento na parte superior do Column
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, // Alinha o Column na parte inferior
              crossAxisAlignment: CrossAxisAlignment.center, // Centraliza os elementos horizontalmente
              children: [
                Text('Bem-vindo ao PetSocial!'),
                SizedBox(height: 20), // Espaçamento entre o texto e o botão
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Cadastro()),
                    );
                  },
                  child: Text('Ir para Cadastro'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
