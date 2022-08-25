import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shoppingapp/additems.dart';

class addproductseller extends StatefulWidget {
  const addproductseller({Key? key}) : super(key: key);

  @override
  State<addproductseller> createState() => _addproductsellerState();
}

class _addproductsellerState extends State<addproductseller> {
  final firebase = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  TextEditingController storename = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Seller Product Panel",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) => new additems()));
        },
        child: Icon(Icons.add),
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
                                      color: Color.fromARGB(72, 255, 193, 7),
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
                                                            255, 1, 1, 43)),
                                                  ),
                                                  Text(
                                                    "Brand :" + x['brand'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                        color: Color.fromARGB(
                                                            255, 19, 19, 255)),
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
                                                        255, 123, 1, 1)),
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
