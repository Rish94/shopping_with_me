// ignore_for_file: prefer_const_constructors, implementation_imports, unnecessary_import, unused_import, avoid_print, unused_local_variable, unnecessary_null_comparison, duplicate_ignore, use_build_context_synchronously, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoppingapp/customer/customerlogin.dart';
import 'package:shoppingapp/seller.dart';

class csignup extends StatefulWidget {
  const csignup({Key? key}) : super(key: key);

  @override
  State<csignup> createState() => _csignupState();
}

class _csignupState extends State<csignup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confermpassword = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zipcode = TextEditingController();

  final firebase = FirebaseFirestore.instance;
  // final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Sign Up",
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
        // ignore: prefer_const_literals_to_create_immutables
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  TextField(
                    controller: email,
                    decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Enter Your Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: city,
                    decoration: InputDecoration(
                        labelText: "City",
                        hintText: "Enter Your City",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: zipcode,
                    decoration: InputDecoration(
                        labelText: "Zip Code",
                        hintText: "Enter Your Area Zip Code",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter Your Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: confermpassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Confirm Password",
                        hintText: "Enter Your Confirm Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                          primary: Color.fromARGB(255, 0, 35, 65)),
                      onPressed: () {
                        // ignore: unnecessary_null_comparison
                        registration();
                      },
                      child: Text("Sign Up")),
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already Have an Account ?   "),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new customerlogin()));
                          },
                          child: Text("Login"))
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

  final auth = FirebaseAuth.instance;

  void registration() async {
    try {
      if (password.text != confermpassword.text) {
        notmatch();
      } else {
        await firebase.collection("customer").doc(email.text).set({
          "email": email.text,
          "password": password.text,
          "city": city.text,
          "zipcode": zipcode.text
        });
        UserCredential usercredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text.trim(), password: password.text.trim());
        registertoast();
        Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new customerlogin()));
      }

      // ignore: use_build_context_synchronously

    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        weakpasswordtoast();
      } else if (e.code == "email-already-in-use") {
        emailalreadyusetoast();
      }
    }
  }

  void registertoast() {
    Fluttertoast.showToast(
        msg: 'Registration Successful',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Color.fromARGB(255, 0, 35, 65),
        textColor: Color.fromARGB(255, 255, 255, 255));
  }

  void weakpasswordtoast() {
    Fluttertoast.showToast(
        msg: 'Weak Password \n(Suggestion: Use Special Characters)',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Color.fromARGB(255, 0, 35, 65),
        textColor: Color.fromARGB(255, 255, 255, 255));
  }

  void emailalreadyusetoast() {
    Fluttertoast.showToast(
        msg: 'Email Already Registered',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Color.fromARGB(255, 0, 35, 65),
        textColor: Color.fromARGB(255, 255, 255, 255));
  }

  void notmatch() {
    Fluttertoast.showToast(
        msg: 'Confirm Password Not match with Password',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Color.fromARGB(255, 255, 255, 255));
  }
}
