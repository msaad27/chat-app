class Message {
  String senderId;
  String receiverId;
  String message;
  String type;
  String timestamp;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.type,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        "senderId": senderId,
        "receiverId": receiverId,
        "message": message,
        "type": type,
        "timestamp": timestamp,
      };

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        senderId: json["senderId"],
        receiverId: json["receiverId"],
        message: json["message"],
        type: json["type"],
        timestamp: json["timestamp"],
      );
}
