import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix/api/api.dart';
import '../model/movie_model.dart';
import 'movie_detailed_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Movie>> popularMovies;
  //TODO: Create variables for upcomingMovies and topRatedMovies
  late Future<List<Movie>> upcomingMovies;
  late Future<List<Movie>> topRatedMovies;

  @override
  void initState() {
    upcomingMovies = Api().getUpcomingMovies();
    //TODO: Initialize upcomingMovies and topRatedMovies
    popularMovies = Api().getPopularMovies();
    topRatedMovies = Api().getTopRatedMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: Set background color with Colors.black12
      backgroundColor: Colors.black12,
      //TODO: Create AppBar for netfix logo and user icon. You can put your own picture for your user icon if you want :) ::: oke!!
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Align(
          alignment: Alignment.centerLeft, 
          child: Image.asset(
            'lib/assets/logo.png',  
            height: 50, 
          ),
        ),
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage('lib/assets/gudetama.jpg'), // or use NetworkImage for an online image
            ),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   //MaterialPageRoute(builder: (context) => ProfilePage()), // Navigate to your Profile page
              // );
            },
          ),
        ],
      ),
      //end of TODO1
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //TODO: Create upcoming movie section. Use 'CarouselSlider.builder' insteed of 'ListView.builder' . Use backDropPath as url of network image. Refer below Popular section!!
              //upcoming movie sec
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: FutureBuilder(
                  future: upcomingMovies,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final movies = snapshot.data!;
                    return CarouselSlider.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index, realIdx) {
                        final movie = movies[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailScreen(
                                  movie: movie,
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/original/${movie.backDropPath}",
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 10,
                                right: 10,
                                child: Text(
                                  movie.title, 
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 5.0,
                                        color: Colors.black,
                                        offset: Offset(1.0,1.0),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 180,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),
                    );
                  },
                ),
              ),

              //END OF TODO2

              //Popular Movies
              const Text(
                'Popular',
                style: TextStyle(color: Colors.white),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                height: 200,
                child: FutureBuilder(
                  future: popularMovies,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final movies = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];

                        return InkWell(
                            onTap: () {
                              //TODO: You sould understand it. It gives movie data to MovieDetailScreen.
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailScreen(
                                    movie: movies[index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 150,
                              margin : const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/original/${movie.posterPath}",
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ));
                      },
                    );
                  },
                ),
              ),

              //TODO: Create Top Rated movie section. Use posterPath as url of network image. Refer Popular section!!
              //Top Rated Movie sec.
              const Text(
                'Top Rated',
                style : TextStyle(
                  color : Colors.white,
                ),
              ),
              Container(
                margin : EdgeInsets.symmetric(vertical:20),
                height : 200,
                child : FutureBuilder(
                  future : topRatedMovies,
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return const Center(
                        child : CircularProgressIndicator(),
                      );
                    }
                    final movies = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount : movies.length,
                      itemBuilder: (context, index){
                        final movie = movies[index];
                        return InkWell(
                          onTap:(){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder : (context) => MovieDetailScreen(movie: movie,),
                              )
                            );
                          },
                          child : Container(
                            width : 150,
                            margin : const EdgeInsets.symmetric(horizontal : 10),
                            decoration : BoxDecoration(
                              color : Colors.white,
                              borderRadius : BorderRadius.circular(15),
                            ),
                            child : ClipRRect(
                              borderRadius : BorderRadius.circular(15),
                              child : Image.network(
                                "https://image.tmdb.org/t/p/original/${movie.posterPath}",
                                height : 120,
                                width : double.infinity,
                                fit : BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }
                    );
                  }
                ),
              ),
              //END OF TODO3
            ],
          ),
        ),
      ),
    );
  }
}
