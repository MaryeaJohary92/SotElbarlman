import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FireBase {
  List personsData=[] ;
  final Future<List<QuerySnapshot<Map<String, dynamic>>>> collectionReference =
  FirebaseFirestore.instance.collection('persons').snapshots().toList();
  Future<List<QuerySnapshot<Map<String, dynamic>>>>? getParlimentPersons(){
    try{
      return collectionReference;
    }catch(e){if (kDebugMode) {
      print(e.toString());
    }
    };
    return null;
  }
}
