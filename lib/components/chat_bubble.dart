import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget{
  final String message;
  final Timestamp timestamp;
  final Color color;
  const ChatBubble({
    super.key, required this.message, required this.timestamp, required this.color,
});

  @override
  Widget build(BuildContext context) {
    // Convertir le Timestamp en DateTime
    DateTime dateTime = timestamp.toDate();
    // Formater le DateTime
    String formattedTimestamp = '${dateTime.hour}:${dateTime.minute}';

    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // change the position of the shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 5), // Espace entre le message et le timestamp
      Text(formattedTimestamp, style: const TextStyle(fontSize: 8, color: Colors.grey)
          ),
        ],
      ),

    );
  }
}