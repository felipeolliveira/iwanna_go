import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iwanna_go/components/image_input.dart';
import 'package:iwanna_go/providers/places_provider.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({Key? key}) : super(key: key);

  @override
  _PlaceFormScreenState createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _textController = TextEditingController();
  File? _pickedImage;

  _setSelectedImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  _submit() {
    if (_textController.text.isEmpty || _pickedImage == null) {
      return;
    }

    Provider.of<PlacesProvider>(context, listen: false)
        .addPlace(_textController.text, _pickedImage!);

    FocusScope.of(context).unfocus();

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Lugar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ImageInput(
              onSelectedImage: _setSelectedImage,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Título',
                filled: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child: ElevatedButton.icon(
              icon: Icon(Icons.add),
              onPressed: _submit,
              label: Text('Adicionar um novo lugar'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).accentColor,
                minimumSize: Size(double.infinity, 40),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
