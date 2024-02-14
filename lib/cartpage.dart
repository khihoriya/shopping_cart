import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'ChangeNotifier.dart';
import 'databaseclass.dart';

class cartpage extends StatefulWidget {
  const cartpage({super.key});

  @override
  State<cartpage> createState() => _cartpageState();
}

class _cartpageState extends State<cartpage> {
  Database? db3;
  List<Map> fav = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() {
    databaseclass().fordatabase().then((value) {
      setState(() {
        db3 = value;
      });
      databaseclass().viewdata(db3!).then((value) {
        setState(() {
          fav = value;
          quantities = List.generate(fav.length, (index) => 1);
          updateSubtotal();
        });
      });
    });
  }

  List<int> quantities = [];

  int subtotal = 0;

  @override
  Widget build(BuildContext context) {
    final CartNotifier cartNotifier = Provider.of<CartNotifier>(context);

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(

          margin: EdgeInsets.all(10),
          child: SwipeButton.expand(
            thumb: Icon(
              Icons.double_arrow_rounded,
              color: Colors.white,
            ),
            child: Text(
              "Swipe to Place order..",
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            activeThumbColor: Color(0xFF0A4D68),
            activeTrackColor: Colors.grey.shade300,
            onSwipe: () {
          
            },
          ),
        ),
          appBar: AppBar(
              backgroundColor: Color(0xFFE3E3AF), title: Text("My cart")),
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Subtotal : ",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "₹ $subtotal",
                            style: TextStyle(
                              color: Color(0xFF1BA165),
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_balance,
                              color:Color(0xFFE06F43)
                          ),
                          Text(
                            "Your order is eligible for free Delivery",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color:Color(0xFFE06F43),),
                          ),
                        ],
                      )
                    ],
                  ),
                  color: Color(0xFFE8BEAC),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Expanded(
                flex: 7,
                child: Container(
                  color: Color(0xFFF1F1E3),
                  child: ListView.builder(
                    itemCount: fav.length,
                    itemBuilder: (context, index) {
                      Map map = fav[index];
                      print("==imgurl = ${map['imageurl']}");
                      int quantity = quantities[index];
                      return Container(
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.all(8),
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black,
                                    image: DecorationImage(
                                        image: AssetImage("${map['imageurl']}"),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "${map['title']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "rs : ${map['pricetag']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "95",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.orangeAccent,
                                        ),
                                        Text(
                                          "(2k Reviews)",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "FREE Delivery",
                                          style: TextStyle(
                                              color: Colors.lightGreen,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                String mystring =
                                                    "${map['pricetag']}";
                                                int value = int.parse(mystring);

                                                if (quantity > 1) {
                                                  quantity--;
                                                  quantities[index] = quantity;
                                                  updateSubtotal();
                                                }
                                              });
                                            },
                                            child: CircleAvatar(
                                                radius: 15, child: Text("-"))),
                                        Text("$quantity"),
                                        InkWell(
                                            onTap: () {
                                              String mystring =
                                                  "${map['pricetag']}";
                                              int value = int.parse(mystring);
                                              print("===price{$value}");

                                              setState(() {
                                                quantity++;
                                                quantities[index] = quantity;
                                                updateSubtotal();
                                              });
                                            },
                                            child: CircleAvatar(
                                              radius: 15,
                                              child: Text("+"),
                                            )),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Icon(Icons.delete),
                                        InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {

                                                            Navigator.pop(context);
                                                          },
                                                          child:
                                                              Text("Discard")),
                                                      TextButton(
                                                          onPressed: () {

                                                            int idd = fav[index]['ID'];

                                                            cartNotifier.decrement();
                                                            databaseclass()
                                                                .deletdata(idd, db3!)
                                                                .then((value) {
                                                              ScaffoldMessenger.of(context)
                                                                  .showSnackBar(SnackBar(

                                                                  backgroundColor: Color(0xFFE8BEAC),
                                                                  content: Text(
                                                                      "Remove Successfully",style: TextStyle(color: Colors.black),)));
                                                              Navigator.pop(context);
                                                              getdata();
                                                            });
                                                          },
                                                          child:
                                                              Text("Confirm")),
                                                    ],
                                                    title: Text(
                                                        "Sure to remove this Order"),
                                                  );
                                                },
                                              );


                                            },
                                            child: Text("Remove")),
                                      ],
                                    )
                                  ]),
                                  height: 100,
                                  width: double.infinity,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void updateSubtotal() {
    subtotal = 0;
    for (int i = 0; i < fav.length; i++) {
      String mystring = "${fav[i]['pricetag']}";
      int value = int.parse(mystring);
      subtotal += value * quantities[i];
    }
  }
}
