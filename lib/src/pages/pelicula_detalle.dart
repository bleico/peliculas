import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula? pelicula =
        ModalRoute.of(context)!.settings.arguments as Pelicula?;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            _crearAppbar(pelicula!),
            SliverList(
                delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 10.0,
                ),
                _posterTitulo(pelicula, context),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _crearCasting(pelicula),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: FadeIn(
          delay: Duration(milliseconds: 300),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              pelicula.title!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
        background: Hero(
          tag: pelicula.uniqueIdBanner,
          child: FadeInImage(
            image: NetworkImage(pelicula.getBackgroundImg()),
            placeholder: AssetImage('assets/img/loading.gif'),
            fadeInDuration: Duration(milliseconds: 150),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _posterTitulo(Pelicula pelicula, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId.toString(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                width: 100,
                image: NetworkImage(pelicula.getPosterImg()),
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pelicula.title.toString(),
                  style: Theme.of(context).textTheme.headline6,
                  overflow: TextOverflow.visible,
                ),
                Text(
                  pelicula.originalTitle.toString(),
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.visible,
                ),
                Text(
                  pelicula.releaseDate.toString(),
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.visible,
                ),
                Row(
                  children: [
                    Icon(Icons.star_rate),
                    Text(
                      pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    _crearCasting(pelicula),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview.toString(),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _crearCasting(Pelicula pelicula) {
    final peliProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(snapshot.data!);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearActoresPageView(List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        itemCount: actores.length,
        // pageSnapping: false,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemBuilder: (context, i) => _actorTarjeta(actores[i]),
      ),
    );
  }

  Widget _actorTarjeta(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              image: NetworkImage(actor.getFoto()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name.toString(),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
