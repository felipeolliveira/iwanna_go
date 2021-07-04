import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPaths;

class ImageInput extends StatefulWidget {
  const ImageInput({
    Key? key,
    required this.onSelectedImage,
  }) : super(key: key);

  final Function(File) onSelectedImage;

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storageImage;

  _takeAPicture() async {
    final ImagePicker picker = ImagePicker();

    try {
      PickedFile? picture = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 70,
        maxWidth: 600,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (picture == null) {
        return;
      }

      setState(() {
        _storageImage = File(picture.path);
      });

      Directory appDir = await sysPaths.getApplicationDocumentsDirectory();
      String fileName = path.basename(picture.path);
      final savedImage = await _storageImage?.copy('${appDir.path}/$fileName');

      if (savedImage != null) {
        widget.onSelectedImage(savedImage);
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[400],
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: _storageImage != null
                ? Image.file(
                    _storageImage as File,
                    fit: BoxFit.cover,
                  )
                : Center(
                    child: Text('Tire uma fotinha :)'),
                  ),
          ),
          Positioned(
            bottom: 30,
            child: ElevatedButton.icon(
              icon: Icon(Icons.camera_alt_outlined),
              onPressed: _takeAPicture,
              label: Text(
                  _storageImage == null ? 'Tirar foto' : 'Tirar nova foto'),
            ),
          )
        ],
      ),
    );
  }
}
