import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'movie_detail.dart';

class MovieShow extends StatefulWidget {
  final List movieList;
  const MovieShow({super.key, required this.movieList});

  @override
  State<MovieShow> createState() => _MovieShowState();
}

class _MovieShowState extends State<MovieShow> {
  Widget spinkit = const SpinKitCircle(
    color: Colors.white,
  );
  TextStyle normal = const TextStyle(fontSize: 10);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.movieList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MovieDetail(index, widget.movieList)));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    width: MediaQuery.of(context).size.width * 0.25,
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500${widget.movieList[index]['poster_path']}',
                    placeholder: (context, url) => SizedBox(
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: 160,
                      child: const Icon(Icons.movie),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Text(
                        '${widget.movieList[index]['original_title']}',
                        overflow: TextOverflow.ellipsis,
                        style: normal,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DrawerCat extends StatefulWidget {
  final String movieType;
  final List movieList;
  const DrawerCat({super.key, required this.movieType, required this.movieList});

  @override
  State<DrawerCat> createState() => _DrawerCatState();
}

class _DrawerCatState extends State<DrawerCat> {
  
  Widget spinkit = const SpinKitCircle(
    color: Colors.white,
  );
  TextStyle normal = const TextStyle(fontSize: 10);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.movieType, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), centerTitle: true,),
      body: GridView.builder(
        itemCount: widget.movieList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: (
            2.5 / 4
          ),
          ), 
        itemBuilder: (context, index){
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MovieDetail(index, widget.movieList)));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500${widget.movieList[index]['poster_path']}',
                    placeholder: (context, url) => SizedBox(
                      width: MediaQuery.of(context).size.width * 0.30,
                      height: 160,
                      child: const Icon(Icons.movie),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Text(
                        '${widget.movieList[index]['original_title']}',
                        overflow: TextOverflow.ellipsis,
                        style: normal,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
    );
  }
}
