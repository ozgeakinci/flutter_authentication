import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _pickImage() async {
    final image = ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);

    if (image != null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x840A7DE7),
        title: Text('HomePage'),
      ),
      body: Center(
        child: Column(children: [
          CircleAvatar(
            radius: 40,
          ),
          TextButton(onPressed: () {}, child: Text('Resim Seç')),
          ElevatedButton(onPressed: () {}, child: Text('Yükle'))
        ]),
      ),
    );
  }
}
