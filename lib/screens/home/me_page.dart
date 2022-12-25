import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shalomhouse/constants/data_keys.dart';
import 'package:shalomhouse/data/user_model.dart';
import 'package:shalomhouse/states/user_notifier.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {

    CollectionReference user = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        title: Text("내 정보 확인"),
      )
    ,
      body: StreamBuilder(
        stream: user.snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Object?>> streamSnapshot) {
          if(streamSnapshot.hasData){
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index){
              final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
              return Card(
                child: ListTile(
                  title: Text(documentSnapshot['phoneNumber']),

                ),
              );
            },
            );
          }
          return Center(child: CircularProgressIndicator());
        },

      ),
    );
  }
}
