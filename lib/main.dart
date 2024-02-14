import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/cartpage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:badges/badges.dart' as badges;

import 'ChangeNotifier.dart';
import 'databaseclass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartNotifier(),
      child: Builder(builder: (BuildContext context) {
        return MaterialApp(
          title: "cart app",
          debugShowCheckedModeBanner: false,
          home: const homepage(),
        );
      }),
    );
  }
}

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List image = [
    "image/m1.jpg",
    "image/m2.jpg",
    "image/m3.jpg",
    "image/m4.jpg",
    "image/m5.jpg",
    "image/m6.jpg",
  ];

  List name = [
    "Mans green",
    "Women kurti",
    "Night wear",
    "Jacket",
    "couple cloths",
    "children"
  ];

  databaseclass dbclass = databaseclass();

  List price = ["1500", "2000", "3500", "1100", "1700", "2100"];

  List<Color> containerColors = List.filled(6, Colors.transparent);

  Database? db;

  Color contanorcolor = Colors.transparent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewdatabase();
  }

  viewdatabase() {
    databaseclass().fordatabase().then((value) {
      setState(() {
        db = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE8BEAC),
        leading: CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage("image/m8.jpg"),
        ),
        title: Text("Hello' Jazz"),
        actions: [
          badges.Badge(
            badgeStyle: badges.BadgeStyle(badgeColor: Colors.yellow),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return cartpage();
                },
              ));
            },
            badgeContent: Consumer<CartNotifier>(
              builder: (context, value, child) {
                return Text(value.getcounter().toString());
              },
            ),
            child: Icon(Icons.add_shopping_cart_sharp),
          ),
          SizedBox(
            width: 15,
          ),
          Icon(Icons.search)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return cartpage();
          },));

        },
        child: badges.Badge(
          badgeStyle: badges.BadgeStyle(badgeColor: Colors.yellow),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return cartpage();
              },
            ));
          },
          badgeContent: Consumer<CartNotifier>(
            builder: (context, value, child) {
              return Text(value.getcounter().toString());
            },
          ),
          child: Icon(Icons.add_shopping_cart_sharp),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                color: Color(0xFFE8BEAC),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Make your Fashion",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Look Mire Charming",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text("Product"),
                        SizedBox(
                          width: 70,
                        ),
                        Text("Select Size"),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 35,
                        ),
                        Text(
                          "${name.length}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        CircleAvatar(
                          child: Text("M"),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          child: Text("X"),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          child: Text("S"),
                        )
                      ],
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                color: Color(0xFFE3E3AF),
                child: Column(
                  children: [
                    Text(
                      "Featured Categories",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage(
                                      "image/fashion-boy-girl-stylish-clothes-colored-wall-background-autumn-bright-clothes-children-child-posing-colored-purple-pink-background-russia-sverdlovsk-6-april-2019_86390-5983.jpg"),
                                ),
                                Text("Children")
                              ],
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage(
                                      "image/men-s-blue-ramen-lover-graphic-printed-oversized-t-shirt-625545-1706082101-1.jpg"),
                                ),
                                Text("Children")
                              ],
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage(
                                      "image/fashion women-small_Small.jpg"),
                                ),
                                Text("Womens")
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: image.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    height: 10,
                    width: 10,
                    color: Color(0xFFF1F1DC),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(image[index]),
                                  fit: BoxFit.fill)),
                          height: 130,
                          width: double.infinity,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  name[index],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("rs : ${price[index]}")
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                String titleee = name[index];
                                String imagename = image[index];
                                String pricetag = price[index];

                                databaseclass()
                                    .insertdata(
                                        titleee, imagename, pricetag, db!)
                                    .then((value) {
                                  if (value) {
                                    cart.increment();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Color(0xFFE8BEAC),
                                          content: Text(
                                            "Add successfully",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Color(0xFFE06F43),
                                          content:
                                              Text("Already added in cart")),
                                    );
                                  }
                                });
                                setState(() {
                                  containerColors[index] = Colors
                                      .yellow; // Change this to your desired color
                                });
                              },
                              child: Container(
                                height: 30,
                                width: 90,
                                child: Center(child: Text("add to cart")),
                                decoration: BoxDecoration(
                                    color: contanorcolor,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.black)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }
}
