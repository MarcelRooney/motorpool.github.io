import 'package:car_rental/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotifTab extends StatelessWidget {
  const NotifTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Request')
            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('error');
            return const Center(child: Text('Error'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              )),
            );
          }

          final data = snapshot.requireData;
          return SizedBox(
            height: 250,
            width: 100,
            child: ListView.builder(
                itemCount: data.docs.length,
                itemBuilder: (context, index) {
                  final userData = data.docs[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(450, 0, 450, 0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 20,
                      child: ListTile(
                        tileColor: Colors.white,
                        leading: const Icon(
                          Icons.notifications,
                          color: Colors.blue,
                        ),
                        title: TextRegular(
                            text: 'Request for: ${userData['vehicle']}',
                            fontSize: 15,
                            color: Colors.black),
                        subtitle: TextRegular(
                            text: 'Status: ${userData['status']}',
                            fontSize: 12,
                            color: Colors.blue),
                        trailing: TextBold(
                            text: DateFormat.yMMMd()
                                .add_jm()
                                .format(userData['dateTime'].toDate()),
                            fontSize: 15,
                            color: Colors.black),
                      ),
                    ),
                  );
                }),
          );
        });
  }
}
