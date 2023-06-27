import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

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

//preference variable and post login api
// Future getLoginCode(Object login) async {
//   Uri url = Uri.parse('https://angular.tastysoftcloud.com/api/auth/signin');
//   String loginJsonEncode = convert.jsonEncode(login);
//   final headers = {'Content-Type': 'application/json'};
//   var response = await http.post(url, body: loginJsonEncode, headers: headers);
//   Map<String, dynamic> jsonResponse =
//       await convert.jsonDecode(response.body) as Map<String, dynamic>;
//   if (response.statusCode == 200) {
//     if (jsonResponse['returncode'] == '200') {
//       setPrefs(jsonResponse['token'], jsonResponse['data']['username'], jsonResponse['data']['userid']);
//       Map returnMap = jsonResponse;
//       return returnMap;
//     }else {
//       Map returnMap = jsonResponse;
//       return returnMap;
//     }
//   }
// }

// void setPrefs(String token, String username, String userid) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setString('token', token);
//   await prefs.setString('username', username );
//   await prefs.setString('userid', userid );
// }
