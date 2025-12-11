import 'package:chat_app/Models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:chat_app/services/chat_service.dart';

class HomeController extends GetxController {
  final firestore = FirebaseFirestore.instance;

  var allUsers = <UserModel>[].obs;
  var filtered = <UserModel>[].obs;
  var recentChats = <UserModel>[].obs;
  var previews = <String, String>{}.obs;

  final ChatService _chatService = ChatService();

  @override
  void onInit() {
    super.onInit();
    final currentUid = FirebaseAuth.instance.currentUser?.uid;

    firestore.collection("users").snapshots().listen((e) async {
      var list = e.docs.map((d) => UserModel.fromJson(d.data())).toList();
      if (currentUid != null) {
        list = list.where((user) => user.uid != currentUid).toList();
      }
      allUsers.value = list;
      filtered.value = allUsers;

      if (currentUid != null) {
        final futures = list.map((u) async {
          final mAll = await _chatService.getLastMessage(currentUid, u.uid);
          final otherMsg = await _chatService.getLastMessageFrom(
            currentUid,
            u.uid,
            u.uid,
          );

          String preview;
          if (otherMsg != null) {
            preview = otherMsg.type == 'text' ? otherMsg.message : '📎 File';
          } else if (mAll != null) {
            if (mAll.senderId == currentUid) {
              preview = mAll.type == 'text'
                  ? 'You: ${mAll.message}'
                  : 'You: 📎 File';
            } else {
              preview = mAll.type == 'text' ? mAll.message : '📎 File';
            }
          } else {
            preview = u.about.isEmpty ? 'Tap to chat' : u.about;
          }

          return {
            'user': u,
            'ts': mAll == null ? 0 : (int.tryParse(mAll.timestamp) ?? 0),
            'preview': preview,
          };
        }).toList();

        final results = await Future.wait(futures);
        final nonNull = results.toList();

        nonNull.sort((a, b) => (b['ts'] as int).compareTo(a['ts'] as int));

        recentChats.value = nonNull.map((r) => r['user'] as UserModel).toList();
        previews.clear();
        for (var r in nonNull) {
          final u = r['user'] as UserModel;
          previews[u.uid] = r['preview'] as String;
        }
        if (recentChats.isNotEmpty) {
          filtered.value = recentChats;
        } else {
          filtered.value = allUsers;
        }
      }
    });
  }

  void search(String query) {
    final source = recentChats.isNotEmpty ? recentChats : allUsers;
    filtered.value = query.isEmpty
        ? source
        : source
              .where(
                (user) =>
                    user.name.toLowerCase().contains(query.toLowerCase()) ||
                    user.email.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
  }
}
