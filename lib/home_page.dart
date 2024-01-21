// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebaseexample/wall_post.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// final firebaseAuthInstance = FirebaseAuth.instance;
// final firebaseStorageInstance = FirebaseStorage.instance;
// final firebaseFirestore = FirebaseFirestore.instance;
// final fcm = FirebaseMessaging.instance;
// final curretUser = FirebaseAuth.instance.currentUser;

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   File? _pickedFile;
//   String _imgUrl = '';
//   final _textController = TextEditingController();

//   @override
//   void initState() {
//     _getUserImage();
//     super.initState();
//   }

//   void _getUserImage() async {
//     try {
//       final user = firebaseAuthInstance.currentUser;
//       final document = firebaseFirestore.collection("users").doc(user!.uid);
//       final documentSnapshot = await document.get();
//       if (documentSnapshot.exists) {
//         setState(() {
//           _imgUrl = documentSnapshot.get("imageUrl");
//         });
//       } else {
//         print('documant Snapshat yok');
//       }
//     } on FirebaseAuthException catch (e) {
//       e.code;
//     } catch (e) {
//       print('hata');
//     }
//   }

//   void _pickImage() async {
//     try {
//       final image = await ImagePicker().pickImage(
//           source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
//       if (image != null) {
//         setState(() {
//           _pickedFile = File(image.path);
//         });
//       }
//     } catch (e) {
//       print('Image Picker hata ${e}');
//     }
//   }

//   void _upload() async {
//     if (_pickedFile != null) {
//       try {
//         final user = firebaseAuthInstance.currentUser;
//         Reference storageRef = firebaseStorageInstance
//             .ref()
//             .child("images")
//             .child("${user!.uid}.jpg");

//         await storageRef.putFile(_pickedFile!);
//         final url = await storageRef.getDownloadURL();
//         print(url);
//         final document = firebaseFirestore.collection("users").doc(user!.uid);
//         if (await document.get().then((doc) => doc.exists)) {
//           await document.update({"imageUrl": url});
//         } else {
//           await document.set({"imageUrl": url});
//         }
//       } catch (e) {
//         print('Kullanıcı görseli eklenmedi $e');
//       }
//     } else {
//       showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: const Text("Uyarı"),
//               content: const Text("Lütfen fotoğraf seçiniz"),
//               actions: [
//                 TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text('Tamam'))
//               ],
//             );
//           });
//     }

//     //Gönderilen image'ı indirmek için
//   }

//   void postMessage() async {
//     if (_textController.text.isNotEmpty) {
//       await FirebaseFirestore.instance.collection("User Posts").add({
//         'UserEmail': curretUser!.email,
//         'Message': _textController.text,
//         'TimeStamp': Timestamp.now(),
//       });
//     }

//     setState(() {
//       _textController.clear();
//     });
//   }

//   // void requestNotificationPermission() async {
//   //   NotificationSettings notificationSettings = await fcm.requestPermission();
//   //   print(notificationSettings.toString());

//   //   // if (notificationSettings.authorizationStatus == AuthorizationStatus.denied)
//   //   String? token = await fcm.getToken();
//   //   print(" token $token");

//   //   if (notificationSettings.authorizationStatus ==
//   //       AuthorizationStatus.denied) {
//   //     //bildirimlere izin verilmedi
//   //   } else {}
//   //   await firebaseFirestore
//   //       .collection("users")
//   //       .doc(firebaseAuthInstance.currentUser!.uid);

//   //   fcm.onTokenRefresh.listen((token) {});
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       appBar: AppBar(
//         actions: [
//           IconButton(
//               onPressed: () {
//                 firebaseAuthInstance.signOut();
//               },
//               icon: const Icon(Icons.logout_outlined))
//         ],
//         backgroundColor: const Color(0x840A7DE7),
//         title: const Text('Firebase Application'),
//       ),
//       body: Center(
//         child: Column(children: [
//           const SizedBox(
//             height: 40,
//           ),
//           if (_imgUrl.isNotEmpty && _pickedFile == null)
//             CircleAvatar(radius: 30, foregroundImage: NetworkImage(_imgUrl)),

//           // if (_pickedFile != null)
//           //   CircleAvatar(radius: 30, foregroundImage: FileImage(_pickedFile!)),
//           TextButton(
//               onPressed: () {
//                 _pickImage();
//               },
//               child: const Text(
//                 'Select Image',
//                 style: TextStyle(color: Colors.black87, fontSize: 16),
//               )),
//           const SizedBox(
//             height: 10,
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 fixedSize: const Size(300, 50),
//                 backgroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 )),
//             onPressed: () {
//               _upload();
//             },
//             child: const Text(
//               'Upload',
//               style: TextStyle(color: Colors.black87, fontSize: 16),
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection("User Posts")
//                   .orderBy('TimeStamp', descending: false)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return ListView.builder(
//                       itemCount: snapshot.data!.docs.length,
//                       itemBuilder: (context, index) {
//                         final post = snapshot.data!.docs[index];
//                         return WallPost(
//                           message: post['Message'],
//                           user: post["UserEmail"],
//                           userAvatar: _imgUrl,
//                           // userAvatar: post["imageUrl"] ?? 'null',
//                         );
//                       });
//                 } else if (snapshot.hasError) {
//                   return Text("Hata ${snapshot.error}");
//                 } else {
//                   return CircularProgressIndicator();
//                 }
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(25.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _textController,
//                     decoration: const InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         hintText: "Duvara birşey yaz"),
//                   ),
//                 ),
//                 //Post Button
//                 IconButton(
//                     onPressed: postMessage,
//                     icon: Icon(Icons.arrow_circle_up_outlined)),
//               ],
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }
