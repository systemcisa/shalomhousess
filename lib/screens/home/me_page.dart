import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  CollectionReference user = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: user
          .where('phoneNumber',
              isEqualTo: FirebaseAuth.instance.currentUser!.phoneNumber)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  child: ListTile(
                    title:
                        Text("내 가입정보 확인 : " + documentSnapshot['phoneNumber']),
                  ),
                );
              });
        }
        return CircularProgressIndicator();
      },
    )
    //   body: Column(
    //     children: [
    //   UserNotifier userNotifier = context.read<UserNotifier>();
    //
    //     if (userNotifier.userModel == null) return;
      //  ],
    //  ),
    );
  }
}
