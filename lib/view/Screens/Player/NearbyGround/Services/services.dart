import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<GroundDetail>> getGroundDetails() {
    return _db.collection('OwnerGroundDetails').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => GroundDetail.fromFirestore(doc)).toList());
  }
}

class GroundDetail {
  final String groundName;
  final String groundOwner;
  final String phoneno;
  final String groundsize;

  final String description;
  final double latitude;
  final double longitude;
  final List<String> imageUrls;
  final String videoUrl;

  GroundDetail({
    required this.groundName,
    required this.groundOwner,
    required this.groundsize,
    required this.phoneno,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.imageUrls,
    required this.videoUrl,
  });

  factory GroundDetail.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return GroundDetail(
      groundName: data['groundname'] ?? '',
      groundOwner: data['name'] ?? '',
      groundsize: data['size'] ?? '',
      phoneno: data['phoneno'] ?? '',
      description: data['groundescription'] ?? '',
      latitude: data['latitude'] ?? 0.0,
      longitude: data['longitude'] ?? 0.0,
      imageUrls: List<String>.from(data['documentUrls']),
      videoUrl: data['videoUrl'] ?? '',
    );
  }
}
