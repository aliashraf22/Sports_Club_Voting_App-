import 'package:cloud_firestore/cloud_firestore.dart';

class CandidateModel {
  CandidateModel({
    this.id,
    this.type,
    this.info,
    this.numberOfVotes,
  });

  factory CandidateModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return CandidateModel(
      id: doc.id,
      type: data['type'] ?? '',
      info: Info.fromJson(data['info']),
      numberOfVotes: data['numberOfVotes'] ?? 0,
    );
  }

  String? id;
  String? type;
  Info? info;
  int? numberOfVotes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    if (info != null) {
      map['info'] = info?.toJson();
    }
    map['numberOfVotes'] = numberOfVotes;
    return map;
  }
}

class Info {
  Info({
    this.name,
    this.bio,
    this.imageUrl,
  });

  Info.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bio = json['bio'];
    imageUrl = json['imageUrl'];
  }

  String? name;
  String? bio;
  String? imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['bio'] = bio;
    map['imageUrl'] = imageUrl;
    return map;
  }
}
