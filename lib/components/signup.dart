import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/components/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  TextEditingController foremail = TextEditingController();
  TextEditingController forPassword = TextEditingController();
  bool con = false;

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'REGISTER',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: SizedBox(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: foremail,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email must not be empty!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Enter your email :',
                              ),
                            ),
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
                              labelText: 'Enter your Password :',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            con = true;
                          });
                          if (formKey.currentState!.validate()) {
                            try {
                              await _auth.createUserWithEmailAndPassword(
                                email: foremail.text,
                                password: forPassword.text,
                              );
                              setState(() {
                                con = false;
                              });
                              showSnackBar('Signup successful');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VerifiedPage()));
                            } on FirebaseAuthException catch (e) {
                              setState(() {
                                con = false;
                              });
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
                              setState(() {
                                con = false;
                              });
                              print(e);
                            }
                          }
                        },
                        child: con ? spinkit : Text('Signup')),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have account',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Signin'))
                    ],
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

//verified page

class VerifiedPage extends StatefulWidget {
  const VerifiedPage({super.key});

  @override
  State<VerifiedPage> createState() => _VerifiedPageState();
}

class _VerifiedPageState extends State<VerifiedPage> {
  @override
  void initState() {
    super.initState();
    if (_auth.currentUser != null) {
      _auth.currentUser!.sendEmailVerification();
    }
  }

  final _auth = FirebaseAuth.instance;
  bool con = false;

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
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            children: [
              Text(
                'Verify your email',
                style: TextStyle(fontSize: 40),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 40),
                child: Text(
                  'A verification has been sent to your email address.Please check your email and click on the link to verify your email address.',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      con = true;
                    });
                    print('>>>>>>>>>>>>>>>> ${_auth.currentUser}');
                    print('_______________________');
                    await _auth.currentUser!.reload();
                    print('>>>>>>>>>>>>>>>> ${_auth.currentUser}');
                    if (_auth.currentUser!.emailVerified) {
                      setState(() {
                        con = false;
                      });
                      showSnackBar('Verification successful');
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    } else {
                      setState(() {
                        con = false;
                      });
                      showSnackBar('verification fail!');
                    }
                  },
                  child: con ? spinkit : Text('Go back to Signin'))
            ],
          ),
        ),
      ),
    );
  }
}
