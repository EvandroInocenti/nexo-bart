import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/patient_message.dart';

class MessageFirebaseService {
  Stream<List<PatientMessage>> messagesStream() {
    final store = FirebaseFirestore.instance;
    final snapshots = store
        .collection('messages')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .orderBy('createdAt', descending: true)
        .snapshots();

    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  // ChatMessage => Map<String, dynamic>
  Map<String, dynamic> _toFirestore(
    PatientMessage msg,
    SetOptions? options,
  ) {
    return {
      'text': msg.text,
      'createdAt': DateTime.now().toIso8601String(),
      'patientName': msg.patientName,
    };
  }

  // Map<String, dynamic> => ChatMessage
  PatientMessage _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    return PatientMessage(
      // id: doc.id,
      text: doc['text'],
      // createdAt: DateTime.parse(doc['createdAt']),
      patientName: doc['userName'],
    );
  }
}
