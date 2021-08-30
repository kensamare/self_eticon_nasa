import 'package:flutter/material.dart';
import 'package:self_eticon_nasa/models/mars_photo_model.dart';

class DetailScreen extends StatelessWidget {
  final MarsPhotoModel photo;

  DetailScreen({required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${photo.camera!.name!} ${photo.id}'),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(tag: '${photo.camera!.name!} ${photo.id}' ,child: Container(width: MediaQuery.of(context).size.width, height: 250, child: Image.network(photo.imgSrc!, fit: BoxFit.fitWidth,),)),
          ],
        ),
      ),
    );
  }
}
