import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/components/movie_card.dart';
import '../api/get_api.dart';

class SearchMovie extends StatefulWidget {
  const SearchMovie({super.key});

  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  final formKey = GlobalKey<FormState>();
  TextEditingController forSearch = TextEditingController();

    Widget spinkit = const SpinKitCircle(
    color: Colors.white,
  );

  List searchMovieList = [];
  Widget show = Text('No content found!', style: TextStyle(fontSize: 25, color: Colors.grey),);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'MOVIEDB',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Image(
            image: AssetImage('./assets/moviedb.png'),
            height: 40,
          ),
        ]),
        actions: [
          IconButton(
            onPressed: (){
              
            }, 
            icon: Icon(Icons.more_vert), 
           )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: formKey,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: 60,
                        child: TextFormField(
                          onFieldSubmitted: (value) async {
                            show = spinkit;
                            searchMovieList = await getSearchMovie(name: value);
                            if(searchMovieList.isEmpty){
                              show = Text('No content found!', style: TextStyle(fontSize: 25, color: Colors.grey),);
                            }
                            setState(() {});
                            print('>>>>>>>>>>>>>$searchMovieList');
                          },
                          controller: forSearch,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search Movie',
                            hintStyle: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        searchMovieList.isEmpty
                            ? 'No result'
                            : '${searchMovieList.length} results',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child:
                  Divider(height: 5, indent: 25, endIndent: 25),
            ),
            Expanded(
                flex: 9,
                child: Center(
                  child: Container(
                    child: searchMovieList.isEmpty
                        ? show
                        : DrawerCat(movieList: searchMovieList),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
