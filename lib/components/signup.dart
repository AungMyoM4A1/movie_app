import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  final formKey = GlobalKey<FormState>();
  TextEditingController foremail = TextEditingController();
  TextEditingController forPassword = TextEditingController();

  Widget spinkit = SpinKitThreeBounce(
    color: Colors.white,
    size: 20,
  );

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
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 150),
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
                  SizedBox(
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              await auth.createUserWithEmailAndPassword(
                                email: foremail.text,
                                password: forPassword.text,
                              );
                              if (user != null) {
                                final uid = user!.uid;
                                print('>>>>>>>>>>>>>>>>>>>>>>>>$uid');
                              }
                              showSnackBar('Signup successful');
                            } on FirebaseAuthException catch (e) {
                              print('>>>>>>>>>>>>>>>>>>>>$e.code');
                              if (e.code == 'weak-password') {
                                showSnackBar('Week password');
                                print('The password provided is too weak.');
                              } else if (e.code == 'invalid-email') {
                                showSnackBar('Invalid Email');
                                print('Invalid Email!');
                              } else if (e.code == 'email-already-in-use') {
                                showSnackBar(
                                    'The account already exists for that email');
                                print(
                                    'The account already exists for that email.');
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        child: Text('Signup')),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
