import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/get_api.dart';
import 'home_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('action');
    if (token != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    }
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController forId = TextEditingController();
  TextEditingController forPassword = TextEditingController();
  bool con = false;

  Widget spinkit = SpinKitThreeBounce(
    color: Colors.white,
    size: 20,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  './assets/moviedb.png',
                  height: 100,
                ),
                Text(
                  'Login Your Account',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: forId,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Userid must not be empty!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 20),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              labelText: 'Enter your id :',
                              labelStyle: TextStyle(fontSize: 15)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: forPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password must not be empty!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 20),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              labelText: 'Enter your Password :',
                              labelStyle: TextStyle(fontSize: 15)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            con = true;
                          });
                          String getResult = await getLoginCode({
                            'userid': forId.text,
                            'password': forPassword.text,
                          });
                          if (getResult == '200') {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          } else {
                            Future.delayed(Duration(milliseconds: 2000), () {
                              setState(() {
                                con = false;
                              });
                            });
                          }
                        }
                      },
                      child: con ? spinkit : Text('Login')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
