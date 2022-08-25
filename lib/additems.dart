import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shoppingapp/addproductseller.dart';

class additems extends StatefulWidget {
  const additems({Key? key}) : super(key: key);

  @override
  State<additems> createState() => _additemsState();
}

class _additemsState extends State<additems> {
  TextEditingController brand = TextEditingController();
  TextEditingController productname = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController storename = TextEditingController();

  var categories = [
    "Clothes",
    "Mens Accesories",
    "Girls Accesories",
    "Shoes",
    "Sunglasses",
    "Others"
  ];
  var firstcategory = "Clothes";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Product",
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
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: brand,
                    decoration: InputDecoration(
                        labelText: "Brand",
                        hintText: "Enter Your Product Brand",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: productname,
                    decoration: InputDecoration(
                        labelText: "Product Name",
                        hintText: "Enter Your Product Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: price,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Price",
                        hintText: "Enter Your Product Price",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: storename,
                    decoration: InputDecoration(
                        labelText: "Store Name",
                        hintText: "Enter Your Store",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  Row(
                    children: [
                      Text("Choose category"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                      ),
                      SizedBox(
                          child: DropdownButton(
                        items: categories.map((String dropDownItems) {
                          return DropdownMenuItem(
                            child: Text(dropDownItems),
                            value: dropDownItems,
                          );
                        }).toList(),
                        onChanged: (String? newItem) {
                          setState(() {
                            firstcategory = newItem!;
                          });
                        },
                        value: firstcategory,
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new addproductseller()));
                        additemsmethod();
                      },
                      child:
                          Text("Submit", style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  final firebase = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  void additemsmethod() async {
    await firebase.collection("Additems").doc(productname.text).set({
      "brand": brand.text,
      "category": firstcategory,
      "productname": productname.text,
      "price": price.text
    });
  }
}
