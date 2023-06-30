import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/components/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    print('>>>>>>>>>>>>>>>>>>>$user');
  }
  
  final auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  final formKey = GlobalKey<FormState>();
  TextEditingController foremail = TextEditingController();
  TextEditingController forPassword = TextEditingController();
  bool con = false;

  Widget spinkit = SpinKitThreeBounce(
    color: Colors.white,
    size: 20,
  );
  //for check login or not!
  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');
    if (id != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    }
  }

  //for validate textfield and corret password

  void validateCheck() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        con = true;
      });
      try {
        await auth.signInWithEmailAndPassword(
            email: foremail.text, password: forPassword.text);
          final uid = user!.uid;
          print('>>>>>>>>>>>>>>$user');
          print('>>>>>>>>>>>>>>>>>>>>>>>>$uid');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('id', uid);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Future.delayed(Duration(milliseconds: 1500), () {
            setState(() {
              con = false;
            });
          });
          showSnackBar('No user found for that email!');
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Future.delayed(Duration(milliseconds: 1500), () {
            setState(() {
              con = false;
            });
          });
          showSnackBar('Wrong password provided for that user!');
          print('Wrong password provided for that user.');
        } else {
          setState(() {
            con = false;
            showSnackBar('Something Wrong!');
          });
        }
      }
    }
  }

  void showSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    ));
  }

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
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: foremail,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email must not be empty!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 20),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              labelText: 'Enter your email :',
                              labelStyle: TextStyle(fontSize: 15)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
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
                        validateCheck();
                      },
                      child: con ? spinkit : Text('Login')),
                ),
                Text('or'),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    label: Text('Signup with Gmail'),
                    icon: Icon(Icons.email),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
