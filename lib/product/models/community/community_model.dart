import 'dart:convert';

import 'package:flutter/foundation.dart';

class CommunityModel {
  final String id;
  final String name;
  final String banner;
  final String avatar;
  final List<dynamic> member;
  final List<String> mods;
  CommunityModel({
    required this.id,
    required this.name,
    required this.banner,
    required this.avatar,
    required this.member,
    required this.mods,
  });

  CommunityModel copyWith({
    String? id,
    String? name,
    String? banner,
    String? avatar,
    List<String>? member,
    List<String>? mods,
  }) {
    return CommunityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      banner: banner ?? this.banner,
      avatar: avatar ?? this.avatar,
      member: member ?? this.member,
      mods: mods ?? this.mods,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'banner': banner,
      'avatar': avatar,
      'member': member,
      'mods': mods,
    };
  }

  factory CommunityModel.fromMap(Map<String, dynamic> map) {
    return CommunityModel(
        id: map['id'] as String,
        name: map['name'] as String,
        banner: map['banner'] as String,
        avatar: map['avatar'] as String,
        member: List<String>.from(
          (map['member'] as List<dynamic>),
        ),
        mods: List<String>.from(map['mods']));
  }

  String toJson() => json.encode(toMap());

  factory CommunityModel.fromJson(String source) =>
      CommunityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CommunityModel(id: $id, name: $name, banner: $banner, avatar: $avatar, member: $member, mods: $mods)';
  }

  @override
  bool operator ==(covariant CommunityModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.banner == banner &&
        other.avatar == avatar &&
        listEquals(other.member, member) &&
        listEquals(other.mods, mods);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        banner.hashCode ^
        avatar.hashCode ^
        member.hashCode ^
        mods.hashCode;
  }
}
