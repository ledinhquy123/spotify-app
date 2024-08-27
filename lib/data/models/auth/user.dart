import 'dart:convert';

import 'package:spotify_project/domain/entities/auth/user.dart';

class UserModel {
  String? fullName;
  String? email;
  String? imageURL;
  UserModel({
    this.fullName,
    this.email,
    this.imageURL,
  });

  UserModel copyWith({
    String? fullName,
    String? email,
    String? imageURL,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      imageURL: imageURL ?? this.imageURL,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'email': email,
      'imageURL': imageURL,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      imageURL: map['imageURL'] != null ? map['imageURL'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      email: email,
      fullName: fullName,
      imageURL: imageURL
    );
  }
}