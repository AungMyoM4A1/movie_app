import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

//getmovie api

Future getMovieList({required String link, required String result}) async{
    Uri url = Uri.parse(link);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          await convert.jsonDecode(response.body) as Map<String, dynamic>;
      List movieList = jsonResponse[result];
      return movieList;
    }
}

//search api

Future getSearchMovie({required String name})async{
   Uri url = Uri.parse('https://api.themoviedb.org/3/search/movie?query=${name}&include_adult=false&language=en-US&page=1&api_key=35e30c88358a559f25d0654f68478055');
    var response = await http.get(url);
    print('>>>>>>>>>>${response.statusCode}');
    if (response.statusCode == 200) {
      var jsonResponse =
          await convert.jsonDecode(response.body) as Map<String, dynamic>;
      List movieList = jsonResponse['results'];
      print('>>>>>>>>>>$movieList');
      return movieList;
    }
}