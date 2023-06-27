import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/components/login.dart';
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Drawer(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.person),
                  ),
                  accountName: Text(
                    userName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  accountEmail: Text(userId, style: TextStyle(fontSize: 15)),
                ),
              ),
              Expanded(
                flex: 5,
                child: ListView.builder(
                    itemCount: drawerList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return drawerList[index]['Text'] != 'Category'
                          ? ListTile(
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
                                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => DrawerCat(movieType: 'Popular Movie', movieList: popularMovieList)));
                                  },
                                  title: Text('Popular'),
                                ),
                                ListTile(
                                  onTap: () {
                                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => DrawerCat(movieType: 'Top Rating Movie', movieList: topRatedMovieList)));
                                  },
                                  title: Text('Top rating'),
                                ),
                                ListTile(
                                  onTap: () {
                                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => DrawerCat(movieType: 'Upcoming Movie', movieList: upComingList)));
                                  },
                                  title: Text('Upcoming'),
                                ),
                                ListTile(
                                  onTap: () {
                                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => DrawerCat(movieType: 'Now Playing Movie', movieList: nowPlayingList)));
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
      appBar: AppBar(
        title: Center(
          child: SizedBox(
            width: 300,
            child: ListTile(
              leading: Image(
                image: AssetImage('./assets/moviedb.png'),
                height: 40,
              ),
              title: Text(
                'MOVIEDB',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Search bar
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Form(
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search Movie',
                        hintStyle: normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
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
