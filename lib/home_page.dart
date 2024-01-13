import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final firebaseAuthInstance = FirebaseAuth.instance;
final firebaseStorageInstance = FirebaseStorage.instance;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _pickedFile;
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
    Reference storageRef =
        firebaseStorageInstance.ref().child("images").child("${user!.uid}.jpg");

    await storageRef.putFile(_pickedFile!);

    //Gönderilen image'ı indirmek için

    final url = await storageRef.getDownloadURL();
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                firebaseAuthInstance.signOut();
              },
              icon: const Icon(Icons.logout_outlined))
        ],
        backgroundColor: Color(0x840A7DE7),
        title: Text('Firebase Application'),
      ),
      body: Center(
        child: Column(children: [
          CircleAvatar(
            radius: 40,
            foregroundImage:
                _pickedFile != null ? FileImage(_pickedFile!) : null,
          ),
          TextButton(
              onPressed: () {
                _pickImage();
              },
              child: const Text('Resim Seç')),
          ElevatedButton(
              onPressed: () {
                _upload();
              },
              child: const Text('Yükle'))
        ]),
      ),
    );
  }
}
