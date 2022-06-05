import 'dart:ui';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final String sender;
  final bool isMine;

  const MessageBubble(
      {required this.text, required this.sender, this.isMine = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Column(
            crossAxisAlignment:
                isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(18.0),
                        topRight: const Radius.circular(18.0),
                        bottomLeft: Radius.circular(isMine ? 18.0 : 0.0),
                        bottomRight: Radius.circular(isMine ? 0.0 : 18.0)),
                    color: isMine
                        ? Colors.blue.shade100
                        : Colors.lightGreenAccent.shade100,
                  ),
                  child: Text(text, style: TextStyle(color: Colors.black))),
              Text(sender,
                  style: TextStyle(
                      fontSize: 10.0,
                      color: isMine
                          ? Color.fromARGB(255, 200, 200, 250)
                          : Color.fromARGB(255, 255, 255, 200)))
            ]),
      ],
    );
  }
}
