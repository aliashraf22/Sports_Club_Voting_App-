import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    this.docId,
    this.userId,
    this.hashedPassword,
    this.votingChoices,
    this.hasVoted,
    this.voteTimestamp,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;

    return UserModel(
      docId: doc.id,
      userId: data['userId'],
      hashedPassword: data['hashedPassword'],
      votingChoices: data['votingChoices'] != null
          ? VotingChoices.fromJson(data['votingChoices'])
          : null,
        hasVoted: data['hasVoted'] ?? false,
      voteTimestamp: data['voteTimestamp'].toString(),
    );
  }

  String? docId;
  String? userId;
  String? hashedPassword;
  VotingChoices? votingChoices;
  bool? hasVoted;
  String? voteTimestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['docId'] = docId;
    map['userId'] = userId;
    map['hashedPassword'] = hashedPassword;
    if (votingChoices != null) {
      map['votingChoices'] = votingChoices?.toJson();
    }
    map['hasVoted'] = hasVoted ?? false;
    map['voteTimestamp'] = voteTimestamp;
    return map;
  }
}

class VotingChoices {
  VotingChoices({
    this.president,
    this.vicePresident,
    this.clubTreasury,
    this.member,
    this.youthMember,
  });

  VotingChoices.fromJson(dynamic json) {
    president = json['President'];
    vicePresident = json['VicePresident'];
    clubTreasury = json['ClubTreasury'];
    member = json['Member'];
    youthMember = json['YouthMember'];
  }

  String? president;
  String? vicePresident;
  String? clubTreasury;
  String? member;
  String? youthMember;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['President'] = president;
    map['VicePresident'] = vicePresident;
    map['ClubTreasury'] = clubTreasury;
    map['Member'] = member;
    map['YouthMember'] = youthMember;
    return map;
  }
}
