import 'package:chat_app/Models/user.dart';
import 'package:chat_app/controllers/chat_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/Common/app_colors.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chatController = Get.find<ChatController>();
  final msgCtrl = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late final UserModel user;
  String? current;

  @override
  void initState() {
    super.initState();
    user = Get.arguments as UserModel;
    current = FirebaseAuth.instance.currentUser?.uid;

    if (current == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed('/login');
      });
      return;
    }

    chatController.openChat(user.uid);
  }

  @override
  void dispose() {
    chatController.closeChat();
    msgCtrl.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(microseconds: 1 ),
          curve:Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(context) {
    if (current == null) {
      return Scaffold(body: Center(child: Text('Redirecting to login...')));
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: InkWell(onTap: () => Get.toNamed('/profile', arguments: user),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: user.profilePic.isEmpty
                    ? null
                    : NetworkImage(user.profilePic),
              ),
              SizedBox(width: 10),
              Text(user.name),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              _scrollToBottom();
              return ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(10),
                itemCount: chatController.messages.length,
                itemBuilder: (_, i) {
                  var m = chatController.messages[i];
                  bool me = m.senderId == current;
                  final theme = Theme.of(context);
                  final isDark = theme.brightness == Brightness.dark;
                  final bubbleBorder = isDark
                      ? AppColors.borderDark
                      : AppColors.borderLight;

                  return Align(
                    alignment: me
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: me
                            ? theme.colorScheme.primary.withOpacity(0.9)
                            : theme.cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: bubbleBorder, width: 1),
                      ),
                      child: m.type == "text"
                          ? Text(
                              m.message,
                              style: TextStyle(
                                color: me
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                            )
                          : Text(
                              "📎 File",
                              style: TextStyle(
                                color: me
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                    ),
                  );
                },
              );
            }),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.attach_file),
                onPressed: () => chatController.sendDocument(),
              ),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: isDark
                          ? AppColors.borderDark
                          : AppColors.borderLight,
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: TextField(
                    controller: msgCtrl,
                    decoration: InputDecoration(
                      hintText: "Message",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  chatController.sendText(msgCtrl.text);
                  msgCtrl.clear();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
