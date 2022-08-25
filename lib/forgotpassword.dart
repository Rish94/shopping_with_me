// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, implementation_imports, unnecessary_import, camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoppingapp/seller.dart';
import 'package:shoppingapp/signup.dart';

class forgotpassword extends StatefulWidget {
  const forgotpassword({Key? key}) : super(key: key);

  @override
  State<forgotpassword> createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpassword> {
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Forgot Password",
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
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Reset Link Send To Your Email !",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          labelText: "Email",
                          hintText: "Enter Your Email"),
                    ),
                    Container(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              primary: Color.fromARGB(255, 0, 35, 65)),
                          onPressed: () {
                            FirebaseAuth.instance.sendPasswordResetEmail(
                                email: email.text.trim());
                            forgottoast();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return seller();
                            }));
                          },
                          child: Text("Send Mail")),
                    ),
                    Container(
                      // ignore: prefer_const_literals_to_create_immutables
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't Have an Account ?  "),
                            OutlinedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SignUp();
                                  }));
                                },
                                child: Text("Sign Up"))
                          ]),
                    ),
                    SizedBox(
                      height: 500,
                    ),
                    Container(
                      child: Text(
                        "In Case Email Not Receive Check Spam Folder Also !\nContact Admin : 8445416675",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            backgroundColor: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    )
                  ]),
            )),
      ),
    );
  }

  void forgottoast() {
    Fluttertoast.showToast(
        msg: 'Email Send To your Registered Mail Id!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Color.fromARGB(255, 0, 35, 65),
        textColor: Color.fromARGB(255, 255, 255, 255));
  }
}
