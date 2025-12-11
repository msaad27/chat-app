import 'package:chat_app/Models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final firestore = FirebaseFirestore.instance;

  String getChatId(String a, String b) =>
      a.hashCode <= b.hashCode ? "$a-$b" : "$b-$a";

  Stream<List<Message>> getMessages(String a, String b) {
    String id = getChatId(a, b);

    return firestore
        .collection("chats")
        .doc(id)
        .collection("messages")
        .orderBy("timestamp")
        .snapshots()
        .map((e) => e.docs.map((d) => Message.fromJson(d.data())).toList());
  }

  Future<Message?> getLastMessage(String a, String b) async {
    String id = getChatId(a, b);
    final snap = await firestore
        .collection('chats')
        .doc(id)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return null;
    return Message.fromJson(snap.docs.first.data());
  }

  Future<Message?> getLastMessageFrom(
    String a,
    String b,
    String fromUid,
  ) async {
    String id = getChatId(a, b);
    final snap = await firestore
        .collection('chats')
        .doc(id)
        .collection('messages')
        .where('senderId', isEqualTo: fromUid)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return null;
    return Message.fromJson(snap.docs.first.data());
  }

  Future<void> sendMessage(Message msg) async {
    String id = getChatId(msg.senderId, msg.receiverId);

    await firestore
        .collection("chats")
        .doc(id)
        .collection("messages")
        .add(msg.toJson());
  }
}
