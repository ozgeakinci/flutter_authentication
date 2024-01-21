import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WallPost extends StatefulWidget {
  const WallPost(
      {Key? key,
      required this.message,
      required this.user,
      required this.userAvatar,
      required this.isMyMessage})
      : super(key: key);

  final String message;
  final String user;
  final String userAvatar;
  final bool isMyMessage;

  @override
  _WallPostState createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          widget.isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: widget.isMyMessage ? Color(0xff1e76fc) : Colors.white,
          borderRadius: const BorderRadius.only(
              topRight: Radius.zero,
              topLeft: Radius.circular(25),
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
        margin: const EdgeInsets.only(top: 25, right: 25, left: 25),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // CircleAvatar(
            //   radius: 20,
            //   backgroundImage: widget.userAvatar.isNotEmpty
            //       ? NetworkImage(widget.userAvatar)
            //       : null,
            // ),
            // const SizedBox(height: 10),
            // Text(
            //   widget.user,
            //   style: const TextStyle(
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            const SizedBox(height: 10),
            Text(
              widget.message,
              style: TextStyle(
                  color: widget.isMyMessage ? Colors.white : Colors.black,
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
