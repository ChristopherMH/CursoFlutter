
import 'dart:convert';
import 'dart:io';

import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mime_type/mime_type.dart';

import 'package:formvalidation/src/models/producto_model.dart';

class ProductosProvider {

  final String _url = 'https://flutter-varios-e3cd2-default-rtdb.firebaseio.com';
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearProducto( ProductoModel producto ) async {
    
    final url = '$_url/products.json?auth=${ _prefs.token }';

    final resp = await http.post(Uri.parse(url), body: productoModelToJson(producto) );

    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;

  }

  Future<bool> editarProducto( ProductoModel producto ) async {
    
    final url = '$_url/products/${ producto.id }.json?auth=${ _prefs.token }';

    final resp = await http.put(Uri.parse(url), body: productoModelToJson(producto) );

    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;

  }



  Future<List<ProductoModel>> cargarProductos() async {

    final url  = '$_url/products.json?auth=${ _prefs.token }';
    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = new List();


    if ( decodedData == null ) return [];

    if(decodedData['error'] != null) return [];

    decodedData.forEach( ( id, prod ){

      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;

      productos.add( prodTemp );

    });

    // print( productos[0].id );

    return productos;

  }


  Future<int> borrarProducto( String id ) async { 

    final url  = '$_url/products/$id.json?auth=${ _prefs.token }';
    final resp = await http.delete(Uri.parse(url));

    print( resp.body );

    return 1;
  }


  Future<String> subirImagen( File imagen ) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dmtadiphq/image/upload?upload_preset=kt8ik7vi');
    final mimeType = mime(imagen.path).split('/'); //image/jpeg
    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file', 
      imagen.path,
      contentType: MediaType( mimeType[0], mimeType[1] )
    );

    imageUploadRequest.files.add(file);


    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      print('Algo salio mal');
      print( resp.body );
      return null;
    }
    final respData = json.decode(resp.body);
    print( respData);
    return respData['secure_url'];
  }
}