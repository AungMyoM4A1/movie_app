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
  @override
  void initState() {
    super.initState();
    showMovie();
  }

  Future showMovie() async {
    popularMovieList = await getmovieList(type: 'popular');
    topRatedMovieList = await getmovieList(type: 'top_rated');
    nowPlayingList = await getmovieList(type: 'now_playing');
    upComingList = await getmovieList(type: 'upcoming');
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
  TextStyle header = const TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
  TextStyle normal =
      const TextStyle(fontWeight: FontWeight.normal, fontSize: 12.5, height: 2);

  List<Map<String, dynamic>> drawerList = [
    {'icon': Icons.home, 'Text': 'Home'},
    {'icon': Icons.mail, 'Text': 'EMail'},
    {'icon': Icons.category_outlined, 'Text': 'Category'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                // height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      foregroundImage: AssetImage('./assets/MovieDv.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'UserName',
                        style: header,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                flex: 3,
                // height: MediaQuery.of(context).size.height * 0.5,
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
                                  title: Text('Popular'),
                                ),
                                ListTile(
                                  title: Text('Top rating'),
                                ),
                                ListTile(
                                  title: Text('Upcoming'),
                                )
                              ],
                            );
                    }),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, right: 20),
                    child: Align(
                      alignment: FractionalOffset.bottomRight,
                      child: TextButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.remove('action');
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
        centerTitle: true,
        title: const Text(
          'THE MOVIEDB',
          style:
              TextStyle(color: Color(0xFF44D8F1), fontWeight: FontWeight.bold),
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
              padding: const EdgeInsets.only(bottom: 20.0, left: 20),
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
              padding: const EdgeInsets.only(bottom: 20.0, left: 20),
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
              padding: const EdgeInsets.only(bottom: 20.0, left: 20),
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
              padding: const EdgeInsets.only(bottom: 20.0, left: 20),
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
