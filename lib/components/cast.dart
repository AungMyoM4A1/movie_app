import 'package:flutter/material.dart';
import 'package:movie_app/api/get_api.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CastList extends StatefulWidget {
  final String movieName;
  final int id;
  const CastList(this.movieName, this.id, {super.key});

  @override
  State<CastList> createState() => _CastListState();
}

class _CastListState extends State<CastList> {
  @override
  void initState() {
    super.initState();
    setCastList();
  }

  Future setCastList() async {
    castList = await getmovieList(castid: widget.id);
    setState(() {});
  }

  List castList = [];
  Widget spinkit = const SpinKitCircle(
    color: Colors.white,
  );
  TextStyle header = const TextStyle(fontWeight: FontWeight.bold, fontSize: 15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.movieName),
      ),
      body: castList.isEmpty
          ? SizedBox(
              height: MediaQuery.of(context).size.height * 1, child: spinkit)
          : ListView.builder(
              itemCount: castList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  child: ListTile(
                    leading: castList[index]['profile_path'] == null
                        ? const CircleAvatar(
                            child: Icon(Icons.movie),
                          )
                        : CircleAvatar(
                            foregroundImage: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${castList[index]['profile_path']}'),
                          ),
                    title: Text('${castList[index]['name']}'),
                    subtitle: Text('${castList[index]['character']}'),
                  ),
                );
              }),
    );
  }
}
