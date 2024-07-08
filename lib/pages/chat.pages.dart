import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:message_app/components/chat_bubble.dart';
import 'package:message_app/components/my_text_fields.dart';
import 'package:message_app/services/auth/auth.services.dart';
import 'package:message_app/services/chat/chat.services.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const ChatPage({super.key, required this.receiverUserEmail, required this.receiverUserID});
  @override
  State<ChatPage> createState() => _ChatPageState();

}

class _ChatPageState extends State<ChatPage>{
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(widget.receiverUserID, _messageController.text);
      _messageController.clear();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),backgroundColor: Colors.grey.shade300,
      ),
      backgroundColor: Colors.grey.shade100, // Ajouter un fond jaune ici
      body: Column(
        children: [
          Expanded(
              child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList(){
    return StreamBuilder(
        stream: _chatService.getMessages(widget.receiverUserID, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot){
          if(snapshot.hasError){
          return Text('Error${snapshot.error}');
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return Text('Loading...');
          }
          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        }
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    //alignement des messages
    var alignement = (data['senderId'] == _firebaseAuth.currentUser!.uid)
    ? Alignment.centerRight: Alignment.centerLeft;

    // Définir la couleur des bulles de chat
    Color bubbleColor = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Colors.blueGrey.shade100
        : Colors.white; // Couleur pour le récepteur

    return Container(
      alignment: alignement,
      child: Padding(
        padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? CrossAxisAlignment.end: CrossAxisAlignment.start,

        mainAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? MainAxisAlignment.end: MainAxisAlignment.start,
        children: [
          Text(data['senderEmail']),
          const SizedBox(height: 5), //ajouter de l'espace entre les messages
          //Text(data['message']),
          ChatBubble(
            message: data['message'],
            timestamp: data['timestamp'],
            color: bubbleColor, // Passer la couleur
          ),

        ],
      ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MyTextField(
                  controller: _messageController,
                  hintText: 'Entrer message',
                  obscureText: false,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: sendMessage,
              icon: Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

}