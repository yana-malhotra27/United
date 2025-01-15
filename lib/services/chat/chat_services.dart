import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:united/models/message.dart';
//The ChatService class provides backend functionality for managing user streams, sending messages, and retrieving chat messages in a Flutter app integrated with Firebase.
//user stream
//send messages
//retrieve messages
class ChatService {
  // get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //User Stream
  //Fetches a real-time stream of users from the Users collection in Firestore.
  // get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() { //list of maps where it has email id and maybe id
    return _firestore.collection("Users").snapshots().map((snapshot) { //Uses snapshots() to listen for real-time updates.
      return snapshot.docs.map((doc) { //Maps each document in the Users collection to a list of user data.
        // go through each individual user
        final user = doc.data();
        //return user
        return user;
      }).toList();
    });
  }

  // send message
  //Sends a message and saves it in the appropriate chat room.
  Future<void> sendMessages(String recieverId, message) async {
    //Fetches the sender's ID and email from Firebase Auth.
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    //Uses the Message model to structure the message data.
    //create a new message
    Message newMessage = Message(
      senderId: currentUserID,
      senderEmail: currentUserEmail,
      recieverId: recieverId,
      message: message,
      timestamp: timestamp,
    );
    //Combines and sorts the sender's and receiver's IDs to create a unique chat room ID.
    //construct that room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, recieverId];
    ids.sort(); //sort the ids (this ensure the chatroomID is the same for any 2 people)
    String chatRoomID = ids.join('_');
    //Adds the message to the messages subcollection under the chat_rooms document.
    //add new message to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(
          newMessage.toMap(),
        );
  }


  // get messages
  //Generate Chat Room ID
  //Fetch Messages
  //Returns a stream that updates whenever new messages are added.
  Stream<QuerySnapshot> getMessages(
    String userID,
    otherUserID,
  ) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection('messages')
        .orderBy("timestamp", descending: false) //Orders messages by their timestamp in ascending order.
        .snapshots();
  }
}