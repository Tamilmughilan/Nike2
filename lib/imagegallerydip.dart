import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class GalleryApp extends StatefulWidget {
  @override
  _GalleryAppState createState() => _GalleryAppState();
}

class _GalleryAppState extends State<GalleryApp> {
  List<File> _images = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Gallery")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: _images.isEmpty ? 12 : _images.length,
          itemBuilder: (context, index) {
            if (_images.isEmpty) {
              // Show dummy text when no images are picked
              return Container(
                color: Colors.grey[300],
                child: Center(
                  child: Text(
                    "Image ${index + 1}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            } else {
              // Show picked images
              return GestureDetector(
                onTap: () {},
                child: Image.file(_images[index], fit: BoxFit.cover),
              );
            }
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "camera",
            child: const Icon(Icons.camera_alt),
            onPressed: () => _pickImage(ImageSource.camera),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "gallery",
            child: const Icon(Icons.photo_library),
            onPressed: () => _pickImage(ImageSource.gallery),
          ),
        ],
      ),
    );
  }
}
