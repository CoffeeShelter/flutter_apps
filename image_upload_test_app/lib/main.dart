import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 이미지 컨테이너
            Expanded(
              child: Container(
                //height: 550,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[800],
                ),
                child: Center(
                  child: _image == null
                  ? const CircularProgressIndicator()
                  //? const Text('No image selected')
                  : Image.file(
                    File(_image!.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            
            // 버튼 컨테이너
            SizedBox(
              width: 50,
              child: ElevatedButton(
                onPressed: getImageFromGallery,
                child: const Text("Upload"),
              ),
            ),
          ],
        ), 
      ),
    );
  }

  

  Future getImageFromGallery() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

}
