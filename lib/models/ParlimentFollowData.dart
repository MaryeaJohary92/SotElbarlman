import 'package:cloud_firestore/cloud_firestore.dart';

class ParlimentCardFollowData {
  String post;
  String id;
  Timestamp time;


  // Constructor
  ParlimentCardFollowData({required this.post,required this.id,required this.time});

  // toMap for Sembast storage - sembast stores data as JSON strings
  Map<String, dynamic> toMap() {
    return {
      'post': post,
      'id':id,
      'time':time,
    };
  }

  // From map, for sembast storage
  static ParlimentCardFollowData fromMap(Map<String, dynamic> map) {
    return ParlimentCardFollowData(
      post: map['post'],
      id: map['id'],
      time: map['time'],
    );
  }
}