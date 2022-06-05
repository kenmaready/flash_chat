import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
//
import '../widgets/message_bubble.dart';
import 'welcome_screen.dart';
import '../constants.dart' show kTextInputDecoration;

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _textInputController = TextEditingController();
  final _scrollController = ScrollController();
  User? user;
  String? message;

  void getCurrentUser() async {
    final checkUser = _auth.currentUser;
    if (checkUser != null) {
      user = checkUser;
      print('user: ${user?.email}');
    }
  }

  void submitMessage() async {
    if (message != '') {
      await _firestore.collection('messages').add({
        'text': message,
        'sender': user?.email,
        'createdAt': Timestamp.now()
      });
      _textInputController.clear();
      message = '';
    }
  }

  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flash Chat'),
        actions: [
          TextButton(
            onPressed: () async {
              await _auth.signOut();
              setState(() => user = null);
              Navigator.of(context).popAndPushNamed(WelcomeScreen.routeName);
            },
            child: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('messages')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  var messageList = <Widget>[];
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator(
                        color: Colors.lightBlueAccent);
                  }
                  final messages = snapshot.data?.docs;
                  if (messages != null) {
                    for (var message in messages) {
                      final text = message.get('text');
                      final sender = message.get('sender');
                      messageList.add(MessageBubble(
                          text: text,
                          sender: sender,
                          isMine: sender == user?.email));
                    }
                  }
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 18.0),
                      children: messageList,
                    ),
                  );
                }),
            TextField(
              onChanged: (value) => setState(() => message = value),
              onSubmitted: (value) => submitMessage,
              decoration: kTextInputDecoration.copyWith(
                hintText: 'your message',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: submitMessage,
                ),
              ),
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scrollDown,
        child: Icon(Icons.arrow_downward),
        backgroundColor: Colors.white,
        elevation: 12.0,
        mini: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    );
  }
}
