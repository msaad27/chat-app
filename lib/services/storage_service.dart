import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final storage = FirebaseStorage.instance;

  Future<String> uploadFile(File file, String path) async {
    var ref = storage.ref(path);
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}
