import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Películas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(
                context: context, 
                delegate: DataSearch(),
                // query: 'Hola' por si queremos texto predeterminado en el
              );
            },
          )
        ],
      ),
      //SafeArea para que el texto no se muestre donde están las notificaciones y estorbe con el notch
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context)
          ],
        ),
      ) 
    );
  }

  Widget _swiperTarjetas() {

    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot <List> snapshot) {
        if(snapshot.hasData){
          return CardSwiper(
            peliculas: snapshot.data,
          );
        }else{
          return Container(height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(child: Text('Populares', style: Theme.of(context).textTheme.subtitle1,),
          padding: EdgeInsets.only(left: 20.0),
          ),
          SizedBox(height: 5.0,),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot <List> snapshot) {
              if(snapshot.hasData){
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,);
              }else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
      width: double.infinity,
    );
  }
}