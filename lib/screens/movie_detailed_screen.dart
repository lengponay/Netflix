import 'package:flutter/material.dart';
import '../model/movie_model.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  const MovieDetailScreen({super.key, 
  required this.movie
  });

  @override
  MovieDetailScreenState createState() => MovieDetailScreenState();
}

class MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SingleChildScrollView(
          child: Column(
        children: [

          //TODO: Put the back drop image with "https://image.tmdb.org/t/p/original/${widget.movie.backDropPath}". Don't forget there is back button on the image of left top side. ` ok
          // back drop image with ".." dak vea nv krouy
          Stack(
              children: [
                Container(
                  height: size.height * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://image.tmdb.org/t/p/original/${widget.movie.backDropPath}",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            //END OF TODO1

          Padding(
            padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //TODO: Put the title, relased date, and overview
                //dak title release date and description seng teat
                Text(
                    widget.movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.movie.releaseDate,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                ),
                const SizedBox(height: 20),
                Text(
                    widget.movie.overview,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.5,
                    ),
                ),
              ],
            ),
          ),

        ],
      )),
    );
  }
}
