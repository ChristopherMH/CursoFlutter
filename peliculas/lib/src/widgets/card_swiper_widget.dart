import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenZise = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {

          

          return Hero(
              tag: peliculas[index].id,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]),
                    child: FadeInImage(
                    image: NetworkImage(peliculas[index].getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                  )
              )
            )
          );
        },
        itemCount: peliculas.length,
        //SwiperPagination: muestra con puntos los elementos que hay
        // pagination: new SwiperPagination(),
        //SwiperControl: flechas en el Swiper < >
        // control: new SwiperControl(),
        itemWidth: _screenZise.width * 0.7,
        itemHeight: _screenZise.height * 0.5,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
