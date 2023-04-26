//write functions for a chat service using firebase rrealtime databse
import 'package:bitsapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreChannelService {
  static final _firestore = FirebaseFirestore.instance.collection('Channels');

  static Future<void> addMessageToChannel(
      String channelId, Message message) async {
    await _firestore
        .doc(channelId)
        .collection("messages")
        .doc(message.time.toString())
        .set(message.toJson());
    await _firestore.doc(channelId).set({
      "lastMessage": message.toJson(),
    }, SetOptions(merge: true));
  }
}
