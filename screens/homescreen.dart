import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/api/food_api.dart';
import 'package:firebasetest/models/food.dart';
import 'package:firebasetest/notifier/food_notifier.dart';
import 'package:firebasetest/screens/contactus.dart';
import 'package:firebasetest/screens/detailFoodUser.dart';
import 'package:firebasetest/screens/foodlist.dart';
import 'package:flutter/material.dart';
import 'package:firebasetest/screens/mainscreen.dart';
import 'package:provider/provider.dart';

import 'detail.dart';
import 'food_form.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    FoodNotifier foodNotifier =
        Provider.of<FoodNotifier>(context, listen: false);
    getFoods(foodNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);

    Future<void> _refreshList() async {
      getFoods(foodNotifier);
    }

    print("building Feed");
    return Container(
        child: Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Menu List'),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: _signOut),
        ],
      ),
      body: new RefreshIndicator(
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Image.network(
                foodNotifier.foodList[index].image != null
                    ? foodNotifier.foodList[index].image
                    : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                width: 120,
                fit: BoxFit.fitWidth,
              ),
              title: Text(foodNotifier.foodList[index].name),
              subtitle: Text(foodNotifier.foodList[index].price),
              onTap: () {
                foodNotifier.currentFood = foodNotifier.foodList[index];
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return FoodDetailUser();
                }));
              },
            );
          },
          itemCount: foodNotifier.foodList.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.black,
            );
          },
        ),
        onRefresh: _refreshList,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'button2',
            onPressed: () {
              foodNotifier.currentFood = null;
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return Contact();
                }),
              );
            },
            child: Icon(Icons.phone),
            foregroundColor: Colors.white,
          ),
        ],
      ),
    ));
  }
}

Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
  runApp(new MaterialApp(
    home: new MainScreen(),
  ));
}
