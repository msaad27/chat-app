class UserModel {
  String uid;
  String name;
  String email;
  String profilePic;
  String about;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profilePic,
    required this.about,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "profilePic": profilePic,
        "about": about,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        profilePic: json["profilePic"],
        about: json["about"],
      );
}
