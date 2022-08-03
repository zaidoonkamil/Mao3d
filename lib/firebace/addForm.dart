import 'package:cloud_firestore/cloud_firestore.dart';

class AddForm {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final Stream<QuerySnapshot> getDataStream = FirebaseFirestore.instance.collection('users')
    .snapshots();

  CollectionReference deleteData = FirebaseFirestore.instance.collection('users');

  Future addUser(
    String? name,
    String? phone,
    String?dateTimeSelected,
    String? dateDaySelected,
     int? color,
  ) {
    return users
        .add({
          'name': name,
          'phone': phone,
          'Day Time': dateDaySelected,
          'Meet Time': dateTimeSelected,
       'color': color,
        })
        // ignore: avoid_print
        .then((value) => print("User Added"))
        // ignore: avoid_print
        .catchError((error) => print("Failed to add user: $error"));
  }

}
