// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiper({required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

/*
    return CarouselSlider.builder(
      itemCount: this.peliculas.length,
      itemBuilder: (context, index, realIndex) =>
          MoviePosterImage(pelicula: this.peliculas[index]),
      options: CarouselOptions(
          autoPlay: true, aspectRatio: 2.0, enlargeCenterPage: true),
    );
    */

    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Swiper(
        autoplay: true,
        layout: SwiperLayout.STACK,
        itemHeight: _screenSize.height * 0.44,
        itemWidth: _screenSize.width * 0.48,
        itemBuilder: (BuildContext context, int index) {
          peliculas[index].uniqueId = '${peliculas[index]}-tarjeta';
          return Column(
            children: [
              Text(
                peliculas[index].title.toString(),
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.visible,
              ),
              SizedBox(
                height: 8,
              ),
              Hero(
                tag: peliculas[index].id.toString(),
                transitionOnUserGestures: true,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'detalle',
                        arguments: peliculas[index]),
                    child: FadeInImage(
                      image: NetworkImage(peliculas[index].getPosterImg()),
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        itemCount: peliculas.length,
      ),
    );
  }
}

class MoviePosterImage extends StatelessWidget {
  const MoviePosterImage({
    Key? key,
    required this.pelicula,
  }) : super(key: key);

  final Pelicula pelicula;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, 'detalle', arguments: pelicula),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Hero(
              tag: pelicula.uniqueIdBanner,
              child: FadeInImage(
                image: NetworkImage(pelicula.getBackgroundImg()),
                placeholder: AssetImage('assets/img/loading.gif'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ],
    );
  }
}
