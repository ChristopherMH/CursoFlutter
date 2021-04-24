import 'dart:io';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  final estiloTexto = new TextStyle(fontSize: 25);
  final int conteo = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Título'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Número de taps:', style: estiloTexto),
            Text('$conteo', style: estiloTexto),
        ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          print('Hola Mundo!');
          // conteo++;
        },
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, localización del botón.
    );
  }
}