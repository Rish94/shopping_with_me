import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class customerpage extends StatefulWidget {
  const customerpage({Key? key}) : super(key: key);

  @override
  State<customerpage> createState() => _customerpageState();
}

class _customerpageState extends State<customerpage> {
  final firebase = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Our Products",
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
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/images/all.png'), fit: BoxFit.cover)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<QuerySnapshot>(
                  stream: firebase.collection("Additems").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, i) {
                            QueryDocumentSnapshot x = snapshot.data!.docs[i];
                            return Padding(
                              padding: EdgeInsets.all(6),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      color: Color.fromARGB(255, 0, 20, 87),
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(children: [
                                        Center(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                8,
                                            height: 50,
                                            child: Icon(Icons
                                                .production_quantity_limits),
                                            color: Colors.white,
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            height: 50,
                                            width: 150,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    x['productname'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255)),
                                                  ),
                                                  Text(
                                                    "Brand :" + x['brand'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                        color: Color.fromARGB(
                                                            222, 254, 241, 0)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 50,
                                          width: 80,
                                        ),
                                        Center(
                                          child: SingleChildScrollView(
                                            child: Container(
                                              height: 50,
                                              width: 60,
                                              child: Text(
                                                x['price'] + "Rs",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
