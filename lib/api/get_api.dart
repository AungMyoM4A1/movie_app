import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//getmovie api

Future getmovieList({String? type, int? castid, int? similarid}) async {
  Uri url;
  if (type != null) {
    url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$type?language=en-USpage=1&api_key=35e30c88358a559f25d0654f68478055');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          await convert.jsonDecode(response.body) as Map<String, dynamic>;
      List movieList = jsonResponse['results'];
      return movieList;
    }
  } else if (castid != null) {
    url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$castid/credits?language=en-US27page=1&api_key=35e30c88358a559f25d0654f68478055');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          await convert.jsonDecode(response.body) as Map<String, dynamic>;
      List movieList = jsonResponse['cast'];
      return movieList;
    }
  } else if (similarid != null) {
    url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$similarid/similar?language=en-US&page=1&api_key=35e30c88358a559f25d0654f68478055');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          await convert.jsonDecode(response.body) as Map<String, dynamic>;
      List movieList = jsonResponse['results'];
      return movieList;
    }
  }
}

//preference variable and post login api
Future getLoginCode(Object login) async {
  Uri url = Uri.parse('https://angular.tastysoftcloud.com/api/auth/signin');
  String loginJsonEncode = convert.jsonEncode(login);
  final headers = {'Content-Type': 'application/json'};
  var response = await http.post(url, body: loginJsonEncode, headers: headers);
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse =
        await convert.jsonDecode(response.body) as Map<String, dynamic>;
    setPrefs(jsonResponse['token']);
    debugPrint('>>>>>>>>>>>>>>>>>>>>>${jsonResponse['token']}');
    String returnCode = jsonResponse['returncode'];
    return returnCode;
  }
}

void setPrefs(String token) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('action', token);
}