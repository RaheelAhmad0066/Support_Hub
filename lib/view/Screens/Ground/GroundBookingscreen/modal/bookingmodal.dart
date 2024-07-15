import 'package:cloud_firestore/cloud_firestore.dart';

class GBooking {
  final String ground;
  final int players;
  final DateTime date;
  final String timeSlot;

  GBooking({
    required this.ground,
    required this.players,
    required this.date,
    required this.timeSlot,
  });

  factory GBooking.fromMap(Map<String, dynamic> data) {
    return GBooking(
      ground:
          data['groundName'] ?? 'Unknown Ground', // Default value for ground
      players: data['players'] ?? 0, // Default value for players
      date: data['date'] is Timestamp
          ? (data['date'] as Timestamp).toDate()
          : DateTime.tryParse(data['date'] ?? '') ??
              DateTime.now(), // Default value if date is null
      timeSlot:
          data['timeSlot'] ?? 'Unknown Time Slot', // Default value for timeSlot
    );
  }
}
