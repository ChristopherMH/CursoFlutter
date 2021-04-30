import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _valorSlider = 100.0;
  bool _blockearCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Sliders'),
       ),
       body: Container(
         padding: EdgeInsets.only(top: 50.0),
         child: Column(
           children: <Widget> [
             _crearSlider(),
             _checkBox(),
             _crearSwitch(),
             Expanded(child: _crearImagen())
           ],
         )
       ),
    );
  }

  Widget _crearSlider() {
    return Slider(
      activeColor: Colors.indigoAccent,
      label: 'Tamaño de la imagen',
      divisions: 20,
      value: _valorSlider,
      min: 0.0, 
      max: 400.0,
      onChanged: (_blockearCheck) ? null : (value) {
        // print(value);
        setState(() {
          _valorSlider = value;
        });
      },
    );
  }

  Widget _crearImagen() {
    return Image(
      image: NetworkImage('http://www.nintenderos.com/wp-content/uploads/2014/03/257298_2138977193022_1203913981_2639353_4230429_o.jpg'),
      width: _valorSlider,
      fit: BoxFit.contain,
    );
  }

  Widget _checkBox() {
    // return Checkbox(
    //   value: _blockearCheck, 
    //   onChanged: (valor){
    //     setState(() {
    //       _blockearCheck = valor;
    //     });
    //   }
    // );
    return CheckboxListTile(
      value: _blockearCheck,
      onChanged: (valor){
        setState(() {
          _blockearCheck = valor;
        });
      },
      title: Text('Bloquear Slider'),
    );
  }

  Widget _crearSwitch() {
    return SwitchListTile(
      value: _blockearCheck,
      onChanged: (valor){
        setState(() {
          _blockearCheck = valor;
        });
      },
      title: Text('Bloquear Slider'),
    );
  }
}