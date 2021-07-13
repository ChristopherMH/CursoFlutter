import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';

class HomePage extends StatelessWidget {
  final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: _crearListado(context),
      floatingActionButton: _botones(context),
    );
  }

  _botones(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.deepPurple,
      child: Icon(Icons.add),
      onPressed: ()=> Navigator.pushNamed(context, 'product'),
    );
  }

  Widget _crearListado(BuildContext context) {
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot <List<ProductoModel>> snapshot){
        if(snapshot.hasData){
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i)=> _crearItem(productos[i], context)
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItem(ProductoModel producto, BuildContext context){
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion){
        //TODO: borrar producto
        productosProvider.borrarProducto(producto.id);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            (producto.fotoUrl == null) 
            ? Image(image: AssetImage('assets/no-image.png'))
            : FadeInImage(
              placeholder: AssetImage('assets/jar-loading.gif'), 
              image: NetworkImage(producto.fotoUrl),
              height: 300.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text('${producto.titulo} - ${producto.valor}'),
              subtitle: Text(producto.id),
              onTap: ()=> Navigator.pushNamed(context, 'product', arguments: producto), 
            )
          ],
        ),
      ),
      
    );
  }
}