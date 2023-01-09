// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late User singInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const nameRoute = 'chat-app-screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  String? textChat;
  final _firestor = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        singInUser = user;
        // print(singInUser.email);
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  final chatTextContorller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 135, 0, 161),
        title: Row(children: [
          Image.asset(
            'assets/images/message.png',
            height: 20,
          ),
          SizedBox(
            width: 10,
          ),
          Text('Chat app'),
        ]),
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.close)),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        StrimeBuilderWidget(firestor: _firestor),
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.amber, width: 2),
            ),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              child: TextField(
                controller: chatTextContorller,
                onChanged: (value) {
                  textChat = value;
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  hintText: 'Tipe any thing here',
                  border: InputBorder.none,
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  _firestor.collection('Chat').add({
                    'title': textChat,
                    'sender': singInUser.email,
                    'time': FieldValue.serverTimestamp()
                  });
                  chatTextContorller.clear();
                },
                child: Text('Send'))
          ]),
        ),
      ]),
    );
  }
}

class StrimeBuilderWidget extends StatelessWidget {
  const StrimeBuilderWidget({
    Key? key,
    required FirebaseFirestore firestor,
  })  : _firestor = firestor,
        super(key: key);

  final FirebaseFirestore _firestor;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestor.collection('Chat').orderBy('time').snapshots(),
        builder: (context, snapshot) {
          List<ChatLineWidgets> chatWidgets = [];
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            );
          }
          final chats = snapshot.data!.docs.reversed;
          for (var chat in chats) {
            final chatText = chat.get('title');
            final chatSender = chat.get('sender');
            final crrentUser = chatSender;
            final chatWidget = ChatLineWidgets(
              isMe: crrentUser == singInUser.email,
              sender: chatSender,
              title: chatText,
            );
            chatWidgets.add(chatWidget);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              children: chatWidgets,
            ),
          );
        });
  }
}

class ChatLineWidgets extends StatelessWidget {
  const ChatLineWidgets(
      {Key? key, required this.isMe, required this.sender, required this.title})
      : super(key: key);
  final String title;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: isMe
          ? SidelLeftChat(sender: sender, title: title)
          : SideRigtChat(sender: sender, title: title),
    );
  }
}

class SidelLeftChat extends StatelessWidget {
  const SidelLeftChat({
    Key? key,
    required this.sender,
    required this.title,
  }) : super(key: key);

  final String sender;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(sender),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5,
                      color: Colors.black26,
                      offset: Offset(0, 1)),
                ],
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text('$title ')),
              ),
            ),
            Container(),
          ],
        ),
      ],
    );
  }
}

class SideRigtChat extends StatelessWidget {
  const SideRigtChat({
    Key? key,
    required this.sender,
    required this.title,
  }) : super(key: key);

  final String sender;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(sender),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5,
                      color: Colors.black26,
                      offset: Offset(0, 1)),
                ],
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text('$title ')),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
