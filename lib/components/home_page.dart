import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/components/login.dart';
import 'package:movie_app/components/search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/get_api.dart';
import 'movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = 'User';
  String userId = '';
  final user = FirebaseAuth.instance.currentUser; 

  @override
  void initState() {
    super.initState();
    showMovie();
    getUserDetail();
  }

  void getUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');
    userId = id!;
    setState(() {});
  }

  Future showMovie() async {
    popularMovieList = await getMovieList(
        link:
            'https://api.themoviedb.org/3/movie/popular?language=en-USpage=1&api_key=35e30c88358a559f25d0654f68478055',
        result: 'results');
    topRatedMovieList = await getMovieList(
        link:
            'https://api.themoviedb.org/3/movie/top_rated?language=en-USpage=1&api_key=35e30c88358a559f25d0654f68478055',
        result: 'results');
    nowPlayingList = await getMovieList(
        link:
            'https://api.themoviedb.org/3/movie/now_playing?language=en-USpage=1&api_key=35e30c88358a559f25d0654f68478055',
        result: 'results');
    upComingList = await getMovieList(
        link:
            'https://api.themoviedb.org/3/movie/upcoming?language=en-USpage=1&api_key=35e30c88358a559f25d0654f68478055',
        result: 'results');
    setState(() {});
  }

  List popularMovieList = [];
  List topRatedMovieList = [];
  List nowPlayingList = [];
  List upComingList = [];
  Widget spinkit = const SpinKitFadingCircle(
    color: Colors.white,
    size: 50.0,
  );
  TextStyle header =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5);
  TextStyle normal =
      const TextStyle(fontWeight: FontWeight.normal, fontSize: 12.5, height: 2);

  List<Map<String, dynamic>> drawerList = [
    {'icon': Icons.category_outlined, 'Text': 'Category'},
    {'icon': Icons.movie, 'Text': 'Movies'},
    {'icon': Icons.local_movies, 'Text': 'Series'},
    {'icon': Icons.download, 'Text': 'Downloads'},
    {'icon': Icons.favorite, 'Text': 'Favourites'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.person),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Text('${user!.email}', style: TextStyle(fontSize: 15),),
                ),
                Expanded(
                  flex: 5,
                  child: ListView.builder(
                      itemCount: drawerList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return drawerList[index]['Text'] != 'Category'
                            ? ListTile(
                              onTap: () {
                                return Navigator.pop(context);
                              },
                                leading: Icon(drawerList[index]['icon']),
                                title: Text(drawerList[index]['Text']),
                              )
                            : ExpansionTile(
                                leading: Icon(drawerList[index]['icon']),
                                title: Text(drawerList[index]['Text']),
                                childrenPadding: EdgeInsets.only(left: 50),
                                children: [
                                  ListTile(
                                    onTap: () {
                                     Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Scaffold(
                                        appBar: AppBar(title: Text('Popular Movie', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), centerTitle: true,),
                                        body: DrawerCat(
                                        movieList: popularMovieList
                                        ),
                                      )
                                      ));
                                    },
                                    title: Text('Popular'),
                                  ),
                                  ListTile(
                                    onTap: () {
                                     Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Scaffold(
                                        appBar: AppBar(title: Text('Top Rating Movie', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), centerTitle: true,),
                                        body: DrawerCat(
                                          movieList: topRatedMovieList
                                          ))
                                      ));
                                    },
                                    title: Text('Top rating'),
                                  ),
                                  ListTile(
                                    onTap: () {
                                     Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Scaffold(
                                        appBar: AppBar(title: Text('Upcoming Movie', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), centerTitle: true,),
                                        body: DrawerCat(
                                         movieList: upComingList
                                          ),
                                      ))
                                      );
                                    },
                                    title: Text('Upcoming'),
                                  ),
                                  ListTile(
                                    onTap: () {
                                     Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Scaffold(
                                        appBar: AppBar(title: Text('Now Playing Movie', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), centerTitle: true,),
                                        body: DrawerCat(
                                          movieList: nowPlayingList
                                          ),
                                      )
                                      ));
                                    },
                                    title: Text('Now playing'),
                                  )
                                ],
                              );
                      }),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20, right: 20),
                      child: Align(
                        alignment: FractionalOffset.bottomRight,
                        child: TextButton(
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.remove('id');
                              await prefs.remove('email');
                              await FirebaseAuth.instance.signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                  (route) => false);
                            },
                            child: Text('Logout')),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchMovie()));
            }, 
            icon: Icon(Icons.search), 
           )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Popular list
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, left: 10),
              child: Text(
                'Popular Movies',
                style: header,
              ),
            ),
            popularMovieList.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: spinkit)
                : MovieShow(movieList: popularMovieList),
            const Divider(),
            //______________________________________________________
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, left: 10),
              child: Text(
                'Top Rating Movies',
                style: header,
              ),
            ),
            popularMovieList.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: spinkit)
                : MovieShow(movieList: topRatedMovieList),
            const Divider(),
            //______________________________________________________
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, left: 10),
              child: Text(
                'Now Playing Movies',
                style: header,
              ),
            ),
            popularMovieList.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: spinkit)
                : MovieShow(movieList: nowPlayingList),
            const Divider(),
            //______________________________________________________
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, left: 10),
              child: Text(
                'Upcomming Movies',
                style: header,
              ),
            ),
            popularMovieList.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: spinkit)
                : MovieShow(movieList: upComingList),
          ],
        ),
      ),
    );
  }
}
