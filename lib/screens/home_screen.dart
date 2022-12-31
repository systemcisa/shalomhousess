import 'package:beamer/beamer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shalomhouse/data/user_model.dart';
import 'package:shalomhouse/router/locations.dart';
import 'package:shalomhouse/screens/home/me_page.dart';
import 'package:shalomhouse/screens/home/orders_page.dart';
import 'package:shalomhouse/screens/home/home_page.dart';
import 'package:shalomhouse/screens/home/records_page.dart';
import 'package:shalomhouse/states/user_notifier.dart';
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
    UserModel? userModel = context.read<UserNotifier>().userModel;
    return Scaffold(
      body:
      IndexedStack(
        index: _bottomSelectedIndex,
        children: [
          HomePage(),
          OrdersPage(),
          RecordsPage(),
          MePage(),
        ],
      ),
      floatingActionButton: ExpandableFab(
        distance: 90,
        children: [
          MaterialButton(
            onPressed: () {
              context.beamToNamed('/$LOCATION_INPUT');
            },
            shape: CircleBorder(),
            height: 40,
            color: Theme.of(context).colorScheme.primary,
            child: Icon(Icons.build_sharp),
          ),
          MaterialButton(
            onPressed: () {
              context.beamToNamed('/$LOCATION_RECORD');
            },
            shape: CircleBorder(),
            height: 40,
            color: Theme.of(context).colorScheme.primary,
            child: Icon(Icons.bolt),
          ),
        ],
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
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.green,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.grey), label: '홈',),
            BottomNavigationBarItem(icon: Icon(Icons.build, color: Colors.grey), label: '설비관리'),
            BottomNavigationBarItem(icon: Icon(Icons.bolt, color: Colors.grey,), label: '전기관리'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle, color: Colors.grey), label: 'me'),
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

