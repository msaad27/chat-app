import 'dart:async';
import 'dart:io';

import 'package:chat_app/Models/message.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../services/chat_service.dart';
import '../services/storage_service.dart';

class ChatController extends GetxController {
  final chat = ChatService();
  var messages = <Message>[].obs;

  StreamSubscription<List<Message>>? _sub;
  String? currentUid;
  String? otherUid;

  Future<void> openChat(String other) async {
    currentUid = FirebaseAuth.instance.currentUser?.uid;
    if (currentUid == null) {
      Get.offAllNamed('/login');
      return;
    }
    otherUid = other;
    listen(currentUid!, otherUid!);
  }

  void listen(String a, String b) {
    _sub?.cancel();
    _sub = chat.getMessages(a, b).listen((e) {
      messages.value = e;
    });
  }

  Future<void> closeChat() async {
    await _sub?.cancel();
    _sub = null;
    messages.clear();
    otherUid = null;
  }

  Future<void> sendText(String msg) async {
    if (currentUid == null || otherUid == null) return;
    await chat.sendMessage(
      Message(
        senderId: currentUid!,
        receiverId: otherUid!,
        message: msg,
        type: "text",
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      ),
    );
  }

  Future<void> sendDocument() async {
    if (currentUid == null || otherUid == null) return;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      String url = await StorageService().uploadFile(
        file,
        "docs/${file.path.split('/').last}",
      );
      await sendFile(url, "document");
    }
  }

  Future<void> sendVideo() async {
    if (currentUid == null || otherUid == null) return;
    final picker = ImagePicker();
    XFile? video = await picker.pickVideo(source: ImageSource.gallery);

    if (video != null) {
      String url = await StorageService().uploadFile(
        File(video.path),
        "videos/${video.name}",
      );
      await sendFile(url, "video");
    }
  }

  Future<void> sendFile(String url, String type) async {
    if (currentUid == null || otherUid == null) return;
    await chat.sendMessage(
      Message(
        senderId: currentUid!,
        receiverId: otherUid!,
        message: url,
        type: type,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      ),
    );
  }
}
