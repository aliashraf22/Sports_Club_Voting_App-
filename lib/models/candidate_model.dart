import 'package:cloud_firestore/cloud_firestore.dart';

class CandidateModel {
  CandidateModel({
    this.id,
    this.type,
    this.info,
    this.numberOfVotes,
    this.votersUserIds,
  });

  factory CandidateModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return CandidateModel(
      id: doc.id,
      type: data['type'] ?? '',
      info: Info.fromJson(data['info']),
      numberOfVotes: data['numberOfVotes'] ?? 0,
      votersUserIds: data['votersUserIds'] ?? [],
    );
  }

  String? id;
  String? type;
  Info? info;
  int? numberOfVotes;
  List? votersUserIds;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    if (info != null) {
      map['info'] = info?.toJson();
    }
    map['numberOfVotes'] = numberOfVotes;
    map['votersUserIds'] = votersUserIds;
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
