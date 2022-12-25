import 'package:beamer/beamer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shalomhouse/router/locations.dart';
import 'package:shalomhouse/screens/home/me_page.dart';
import 'package:shalomhouse/screens/home/orders_page.dart';
import 'package:shalomhouse/screens/home/home_page.dart';
import 'package:shalomhouse/widgets/expandable_fab.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _bottomSelectedIndex = 0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:
      IndexedStack(
        index: _bottomSelectedIndex,
        children: [
          HomePage(),
          OrdersPage(),
          MePage(),
        ],
      ),
      floatingActionButton: FloatingActionButton( onPressed: () {context.beamToNamed('/$LOCATION_INPUT');  },

      ),
      appBar: AppBar(
        title: Text('SHALOM HOUSE', style: Theme.of(context).appBarTheme.titleTextStyle,),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                context.beamToNamed("/");
              },
              icon: Icon(CupertinoIcons.nosign)),
        ],),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _bottomSelectedIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: '시설물관리'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'me'),
          ],
          onTap: (index){
            setState((){
              _bottomSelectedIndex = index;
            });
          }
      ),
    );
  }
}

