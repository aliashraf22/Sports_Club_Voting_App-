import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    this.docId,
    this.userId,
    this.hashedPassword,
    this.hasVoted,
    this.voteTimestamp,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;

    return UserModel(
      docId: doc.id,
      userId: data['userId'],
      hashedPassword: data['hashedPassword'],
        hasVoted: data['hasVoted'] ?? false,
      voteTimestamp: data['voteTimestamp'].toString(),
    );
  }

  String? docId;
  String? userId;
  String? hashedPassword;
  bool? hasVoted;
  String? voteTimestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['docId'] = docId;
    map['userId'] = userId;
    map['hashedPassword'] = hashedPassword;
    map['hasVoted'] = hasVoted ?? false;
    map['voteTimestamp'] = voteTimestamp;
    return map;
  }
}