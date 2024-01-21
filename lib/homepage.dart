import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseexample/wall_post.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final firebaseAuthInstance = FirebaseAuth.instance;
final firebaseStorageInstance = FirebaseStorage.instance;
final firebaseFirestore = FirebaseFirestore.instance;
final curretUser = FirebaseAuth.instance.currentUser;

class HomepageNew extends StatefulWidget {
  const HomepageNew({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<HomepageNew> {
  File? _pickedFile;
  String _imageUrl = '';
  final _textController = TextEditingController();

  get firebaseFireStore => null;

  @override
  void initState() {
    _getUserImage();
    super.initState();
  }

  void _getUserImage() async {
    final user = firebaseAuthInstance.currentUser;
    final document = firebaseFirestore.collection("users").doc(user!.uid);
    final documentSnapshot =
        await document.get(); // document.get => dökümanın okunmasını sağlar.
    // documentSnapshot => dökümanın tamamı
    print("documentSnapshot");
    setState(() {
      _imageUrl = documentSnapshot.get(
          "imageUrl"); // documentSnapshot.get => dökümanın içindeki field'ı okur
    });
  }

  void _pickImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);

    if (image != null) {
      setState(() {
        _pickedFile = File(image.path);
      });
    }
  }

  void _upload() async {
    final user = firebaseAuthInstance.currentUser;
    final storageRef =
        firebaseStorageInstance.ref().child("images").child("${user!.uid}.jpg");

    await storageRef.putFile(_pickedFile!);

    final url = await storageRef.getDownloadURL();

    final document = firebaseFireStore.collection("users").doc(user!.uid);

    await document.update({
      'imageUrl': url
    }); // document.update => verilen değeri ilgili dökümanda günceller!
  }

  void postMessage() async {
    if (_textController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': curretUser!.email,
        'Message': _textController.text,
        'TimeStamp': Timestamp.now(),
      });
    }

    setState(() {
      _textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                firebaseAuthInstance.signOut();
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ))
        ],
        backgroundColor: Color(0xff1e76fc),
        title: const Text(
          'Chat App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(children: [
        const SizedBox(
          height: 10,
        ),
        if (_imageUrl.isNotEmpty && _pickedFile == null)
          CircleAvatar(
              radius: 40,
              foregroundImage: NetworkImage(_imageUrl),
              backgroundColor: Colors.grey[500]),
        if (_pickedFile != null)
          //   CircleAvatar(radius: 30, foregroundImage: FileImage(_pickedFile!)),
          TextButton(
              onPressed: () {
                _pickImage();
              },
              child: const Text(
                'Select Image',
                style: TextStyle(color: Colors.black87, fontSize: 16),
              )),
        const SizedBox(
          height: 10,
        ),
        if (_pickedFile != null)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                )),
            onPressed: () {
              _upload();
            },
            child: const Text(
              'Upload',
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ),
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("User Posts")
                .orderBy('TimeStamp', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data!.docs[index];
                      final isMyMessage =
                          post["UserEmail"] == curretUser!.email;
                      return WallPost(
                        message: post['Message'],
                        user: post["UserEmail"],
                        userAvatar: _imageUrl,
                        isMyMessage: isMyMessage,
                        // userAvatar: post["imageUrl"] ?? 'null',
                      );
                    });
              } else if (snapshot.hasError) {
                return Text("Hata ${snapshot.error}");
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.grey.shade300)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: "Bir şeyler yaz...",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              //Post Button
              IconButton(
                  onPressed: postMessage,
                  icon: const Icon(
                    Icons.send_sharp,
                    color: Color(0xffE06F58),
                    size: 40,
                  )),
            ],
          ),
        ),
      ]),
    );
  }
}
