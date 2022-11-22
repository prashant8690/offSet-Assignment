
class UserModel {
  String profilePicture;
  String name;
  int age;

  UserModel(
      {required this.name, required this.age, required this.profilePicture});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      name: json["name"],
      age: json["age"],
      profilePicture: json["profilePicture"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
        "profilePicture": profilePicture,
      };
}
