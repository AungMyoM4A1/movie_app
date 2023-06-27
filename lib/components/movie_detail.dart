import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/api/get_api.dart';
import 'package:movie_app/components/cast.dart';
import 'package:movie_app/components/movie_card.dart';

class MovieDetail extends StatefulWidget {
  final int index;
  final List movieList;
  const MovieDetail(
    this.index,
    this.movieList, {
    super.key,
  });

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  void initState() {
    super.initState();
    setsimilarList();
  }

  Future setsimilarList() async {
    similarList =
        await getMovieList(link: 'https://api.themoviedb.org/3/movie/${widget.movieList[widget.index]['id']}/similar?language=en-US&page=1&api_key=35e30c88358a559f25d0654f68478055', result: 'results');
    setState(() {});
  }

  List similarList = [];
  Widget spinkit = const SpinKitCircle(
    color: Colors.white,
  );
  TextStyle header = const TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
  TextStyle normal =
      const TextStyle(fontWeight: FontWeight.normal, fontSize: 12.5, height: 2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('${widget.movieList[widget.index]['original_title']}')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              //image,rating,release date show card
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500/${widget.movieList[widget.index]['backdrop_path']}',
                      placeholder: (context, url) => SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: spinkit,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.movieList[widget.index]['original_title']}',
                                style: header,
                              ),
                              Text(
                                'Release Date : ${widget.movieList[widget.index]['release_date']}',
                                style: normal,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 65,
                            height: 55,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: const Color(0xFF44D8F1),
                              child: Center(
                                  child: Text(
                                widget.movieList[widget.index]['vote_average']
                                    .toStringAsFixed(1),
                                style: const TextStyle(fontSize: 30),
                                textAlign: TextAlign.center,
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                        style: const ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CastList(
                                      '${widget.movieList[widget.index]['original_title']}',
                                      widget.movieList[widget.index]['id'])));
                        },
                        child: const Text('Show cast')),
                  ],
                ),
              ),
            ),
            //overview show sizebox
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: RichText(
                    text: TextSpan(
                        style: header,
                        text: 'Overview :\n',
                        children: [
                      TextSpan(
                          text: '${widget.movieList[widget.index]['overview']}',
                          style: normal)
                    ])),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Divider(),
            ),
            //recommand movie show sizebox
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Recommanded Movies',
                      style: header,
                    ),
                  ),
                  MovieShow(movieList: similarList)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
