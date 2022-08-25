import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoppingapp/customer/csignup.dart';
import 'package:shoppingapp/customerpage.dart';
import 'package:shoppingapp/forgotpassword.dart';
import 'package:shoppingapp/signup.dart';

class customerlogin extends StatefulWidget {
  const customerlogin({Key? key}) : super(key: key);

  @override
  State<customerlogin> createState() => _customerloginState();
}

class _customerloginState extends State<customerlogin> {
  TextEditingController Email = TextEditingController();
  TextEditingController password = TextEditingController();
  var emailError = null;
  var passwordError = null;
  final firebase = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Welcome",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          backgroundColor: Color.fromARGB(255, 0, 35, 65),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.114,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/images/all.png'),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 220),
              child: Column(children: [
                TextField(
                  maxLength: 50,
                  controller: Email,
                  decoration: InputDecoration(
                    errorText: emailError,
                    labelText: "Email",
                    hintText: "Enter your Email",
                    labelStyle: TextStyle(fontSize: 15, color: Colors.blueGrey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  obscureText: true,
                  maxLength: 50,
                  controller: password,
                  decoration: InputDecoration(
                    errorText: passwordError,
                    labelText: "Password",
                    hintText: "Enter your Password",
                    labelStyle: TextStyle(fontSize: 15, color: Colors.blueGrey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 0, 35, 65)),
                  onPressed: () {
                    setState(() {
                      if (Email.text.isEmpty) {
                        emailError = "Enter your Email";
                      } else if (password.text.isEmpty) {
                        passwordError = "Enter Your Password";
                      }
                    });
                    login();
                  },
                  child: Text("Login"),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new forgotpassword()));
                    },
                    child: Text("Forgot Password ?")),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Don't Have an Account ?  "),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new csignup()));
                      },
                      child: Text("Sign Up"))
                ])
              ]),
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: Email.text.trim(),
        password: password.text.trim(),
      );
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new customerpage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        usernotfound();
      } else if (e.code == 'wrong-password') {
        wrongpassword();
      }
    }
  }

  void usernotfound() {
    Fluttertoast.showToast(
        msg: 'User Not Found for that Email',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Color.fromARGB(255, 255, 255, 255));
  }

  void wrongpassword() {
    Fluttertoast.showToast(
        msg: 'Wrong password provided for that user.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Color.fromARGB(255, 255, 255, 255));
  }
}
